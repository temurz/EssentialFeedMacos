//
//  RemoteFeedImageDataLoaderTests.swift
//  EssentialFeedMacosTests
//
//  Created by Temur on 23/02/2024.
//

import XCTest
import EssentialFeedMacos

class FeedImageDataMapperTests: XCTestCase {
    
    func test_map_throwsInvalidDataErrorOnNon200Response() throws {
        let samples = [199,201,401,500]
        
        try samples.forEach { code in
            XCTAssertThrowsError(
                try FeedImageDataMapper.map(anyData(), from: HTTPURLResponse(statusCode: code))
            )
        }
    }
    
    func test_map_throwsnvalidDataErrorOn200HTTPResponseWithEmptyData() throws {
        let emptyData = Data()
        
        XCTAssertThrowsError(
            try FeedImageDataMapper.map(emptyData, from: HTTPURLResponse(statusCode: 200))
        )
    }
    
    func test_map_deliversReceivedNonEmptyDataOn200HTTPResponse() throws {
        let nonEmptyData = Data("non-empty data".utf8)
        
        let result = try FeedImageDataMapper.map(nonEmptyData, from: HTTPURLResponse(statusCode: 200))
        XCTAssertEqual(result, nonEmptyData)
    }
}
