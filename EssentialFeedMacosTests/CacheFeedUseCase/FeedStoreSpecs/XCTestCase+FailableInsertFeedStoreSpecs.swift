//
//  XCTestCase+FailableInsertFeedStoreSpecs.swift
//  EssentialFeedMacosTests
//
//  Created by Temur on 27/11/2023.
//

import Foundation
import EssentialFeedMacos
import XCTest

extension FailableInsertFeedStoreSpecs where Self: XCTestCase {
    func assertThatInsertDeliversErrorOnInsertionError(_ sut: FeedStore, file: StaticString = #file, line: UInt = #line) {
        let feed = uniqueImageFeed().local
        let timestamp = Date()
        
        let insertionError = insert((feed, timestamp), to: sut)
        XCTAssertNotNil(insertionError, "Expected cache insertion to fail with error")
    }
    
    func assertThatInsertHasNoSideEffectsOnInsertionError(_ sut: FeedStore, file: StaticString = #file, line: UInt = #line) {
        let feed = uniqueImageFeed().local
        let timestamp = Date()
        
        insert((feed, timestamp), to: sut)
        
        expect(sut, toRetrieve: .empty)
    }
}
