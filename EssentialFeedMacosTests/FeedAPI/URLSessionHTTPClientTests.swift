//
//   URLSessionHTTPClientTests.swift
//  EssentialFeedTests
//
//  Created by Temur on 23/09/2023.
//

import XCTest
import EssentialFeedMacos


class URLSessionHTTPClientTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        URLProtocolStub.startInterceptingRequest()
    }
    
    override func tearDown() {
        super.tearDown()
        URLProtocolStub.stopInterceptingRequest()
    }
    
    func test_getFromURL_performsGetRequestWithURL() {
        let url = anyUrl()
        let exp = expectation(description: "Wait for the request")
        URLProtocolStub.observeRequests { request in
            XCTAssertEqual(request.url, url)
            XCTAssertEqual(request.httpMethod, "GET")
            exp.fulfill()
        }
        
        makeSUT().get(from: url) { _ in }
        
        wait(for: [exp], timeout: 1.0)
    }
    
    func test_getFromURL_failsOnRequestError() {
        let requestError = anyNSError()
        let receivedError = resultErrorFor(data: nil, response: nil, error: requestError) as? NSError
        
        XCTAssertEqual(receivedError?.domain, requestError.domain)
        XCTAssertEqual(receivedError?.code, requestError.code)
    }
    
    func test_getFromURL_failsOnAllInvalidRepresentationCases() {
        XCTAssertNotNil(resultErrorFor(data: nil, response: nil, error: nil))
        XCTAssertNotNil(resultErrorFor(data: nil, response: nonHTTPURLResponse(), error: nil))
        XCTAssertNotNil(resultErrorFor(data: anyData(), response: nil, error: nil))
        XCTAssertNotNil(resultErrorFor(data: anyData(), response: nil, error: anyNSError()))
        XCTAssertNotNil(resultErrorFor(data: nil, response: nonHTTPURLResponse(), error: anyNSError()))
        XCTAssertNotNil(resultErrorFor(data: nil, response: anyHTTPURLResponse(), error: anyNSError()))
        XCTAssertNotNil(resultErrorFor(data: anyData(), response: nonHTTPURLResponse(), error: anyNSError()))
        XCTAssertNotNil(resultErrorFor(data: anyData(), response: anyHTTPURLResponse(), error: anyNSError()))
        XCTAssertNotNil(resultErrorFor(data: anyData(), response: nonHTTPURLResponse(), error: nil))
    }
    
    func test_getFromURL_succeedsWithEmptyDataOnHTTPURLResponseWithNilData() {
        let response = anyHTTPURLResponse()
        URLProtocolStub.stub(data: nil, response: response, error: nil)
        
        let exp = expectation(description: "Wait for completion")
        
        makeSUT().get(from: anyUrl()) { result in
            switch result {
            case let .success(receivedData, receivedResponse):
                let emptyData = Data()
                XCTAssertEqual(receivedData, emptyData)
                XCTAssertEqual(receivedResponse.statusCode, response.statusCode)
                XCTAssertEqual(receivedResponse.url, response.url)
            default:
                XCTFail("Expected success, got \(result) instead!")
            }
            
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1.0)
    }
    
    func test_getFromURL_succeedsOnHTTPURLResponseWithData() {
        let data = anyData()
        let response = anyHTTPURLResponse()
        let receivedValues = resultSuccessFor(data: data, response: response, error: nil)
        
        XCTAssertEqual(receivedValues?.data, data)
        XCTAssertEqual(receivedValues?.response.statusCode, response.statusCode)
        XCTAssertEqual(receivedValues?.response.url, response.url)
    }
    
    //MARK: - Helpers
    private func makeSUT(file: StaticString = #filePath, line: UInt = #line) -> HTTPClient   {
        let sut = URLSessionHTTPClient()
        trackForMemoryLeaks(sut, file: file, line: line)
        return sut
    }
    
    private func nonHTTPURLResponse() -> URLResponse {
        return URLResponse(url: anyUrl(), mimeType: nil, expectedContentLength: 0, textEncodingName: nil)
    }
    
    private func anyHTTPURLResponse() -> HTTPURLResponse {
        return HTTPURLResponse(url: anyUrl(), statusCode: 200, httpVersion: nil, headerFields: nil)!
    }
    
    private func anyData() -> Data { return Data() }
    
    private func resultErrorFor(data: Data?, response: URLResponse?, error: Error?, file: StaticString = #filePath, line: UInt = #line) -> Error? {
        let receivedResult = resultFor(data: data, response: response, error: error, file: file, line: line)
        
        switch receivedResult {
        case let .failure(error):
            return error
        default:
            XCTFail("Expected failure with error \(String(describing: error)), got \(String(describing: receivedResult)) instead!", file: file, line: line)
            return nil
        }
    }
    
    private func resultSuccessFor(data: Data?, response: URLResponse?, error: Error?, file: StaticString = #filePath, line: UInt = #line) -> (data: Data, response: HTTPURLResponse)? {
        let receivedResult: HTTPClientResult = resultFor(data: data, response: response, error: nil, file: file, line: line)
        
        switch receivedResult {
        case let .success(data, response):
            return (data, response)
        default:
            XCTFail("Expected success, got \(String(describing: receivedResult)) instead!", file: file, line: line)
            return nil
        }
    }
    
    private func resultFor(data: Data?, response: URLResponse?, error: Error?, file: StaticString = #filePath, line: UInt = #line) -> HTTPClientResult {
        URLProtocolStub.stub(data: data, response: response , error: error)
        let sut = makeSUT(file: file, line: line)
        
        let exp = expectation(description: "Wait for completion")
        var receivedResult: HTTPClientResult!
        sut.get(from: anyUrl()) { result in
            receivedResult = result
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1.0)
        return receivedResult
    }
    
    private class URLProtocolStub: URLProtocol {
        private static var stub: Stub?
        private static var requestObserver: ((URLRequest) -> Void)?
        private struct Stub {
            let data: Data?
            let response: URLResponse?
            let error: Error?
        }
        
        static func stub(data: Data?, response: URLResponse?, error: Error?) {
            stub = Stub(data: data, response: response, error: error )
        }
        
        static func observeRequests(observer: @escaping (URLRequest) -> Void) {
            requestObserver = observer
        }
        
        static func startInterceptingRequest() {
            URLProtocol.registerClass(URLProtocolStub.self)
        }
        
        static func stopInterceptingRequest() {
            URLProtocol.unregisterClass(URLProtocolStub.self)
            stub = nil
            requestObserver = nil
        }
        
        override class func canInit(with request: URLRequest) -> Bool {
            
            return true
        }
        
        override class func canonicalRequest(for request: URLRequest) -> URLRequest {
            return request
        }
        
        override func startLoading() {
            if let requestObserver = URLProtocolStub.requestObserver {
                client?.urlProtocolDidFinishLoading(self)
                return requestObserver(request)
            }
            
            guard let stub = URLProtocolStub.stub else {return}
            
            if let data = stub.data {
                client?.urlProtocol(self, didLoad: data)
            }
            
            if let response = stub.response {
                client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            }
            
            if let error = stub.error {
                client?.urlProtocol(self, didFailWithError: error)
            }
            
            client?.urlProtocolDidFinishLoading(self)
        }
        
        override func stopLoading() {}
    }
}
