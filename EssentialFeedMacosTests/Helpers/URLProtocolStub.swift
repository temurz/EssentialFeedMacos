//
//  URLProtocolStub.swift
//  EssentialFeedMacosTests
//
//  Created by Temur on 24/02/2024.
//

import Foundation
class URLProtocolStub: URLProtocol {
    private static var _stub: Stub?
    private static var stub: Stub? {
        get { return queue.sync { _stub }}
        set { return queue.sync { _stub = newValue }}
    }
    
    private static let queue = DispatchQueue(label: "URLProtocolStub.queue")

    private struct Stub {
        let data: Data?
        let response: URLResponse?
        let error: Error?
        let requestObserver: ((URLRequest) -> Void)?
    }
    
    static func stub(data: Data?, response: URLResponse?, error: Error?) {
        stub = Stub(data: data, response: response, error: error, requestObserver: nil)
    }
    
    static func observeRequests(observer: @escaping (URLRequest) -> Void) {
        stub = Stub(data: nil, response: nil, error: nil, requestObserver: observer)
    }
    
    static func removeStub() {
        stub = nil
    }
    
    override class func canInit(with request: URLRequest) -> Bool {
        
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        
        if let data = URLProtocolStub.stub?.data {
            client?.urlProtocol(self, didLoad: data)
        }
        
        if let response = URLProtocolStub.stub?.response {
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
        }
        
        if let error = URLProtocolStub.stub?.error {
            client?.urlProtocol(self, didFailWithError: error)
        }else {
            client?.urlProtocolDidFinishLoading(self)
        }
        
        URLProtocolStub.stub?.requestObserver?(request)
    }
    
    override func stopLoading() {}
}
