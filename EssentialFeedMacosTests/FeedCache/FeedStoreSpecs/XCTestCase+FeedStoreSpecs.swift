//
//  XCTestCase+FeedStoreSpecs.swift
//  EssentialFeedMacosTests
//
//  Created by Temur on 27/11/2023.
//

import Foundation
import XCTest
import EssentialFeedMacos
extension FeedStoreSpecs where Self: XCTestCase {
    func assertThatRetrieveDeliversEmptyOnEmptyCache(_ sut: FeedStore, file: StaticString = #file, line: UInt = #line) {
        expect(sut, toRetrieve: .empty, file: file, line: line)
    }
    
    func assertThatRetrieveHasNoSideEffectsOnEmptyCache(_ sut: FeedStore, file: StaticString = #file, line: UInt = #line) {
        expect(sut, toRetrieve: .empty, file: file, line: line)
    }
    
    func assertThatRetrieveDeliversFoundValuesOnNonEmptyCache(_ sut: FeedStore, file: StaticString = #file, line: UInt = #line) {
        let feed = uniqueImageFeed().local
        let timestamp = Date()
        
        insert((feed, timestamp), to: sut)
        
        expect(sut, toRetrieve: .found(feed: feed, timestamp: timestamp), file: file, line: line)
    }
    
    func assertThatRetrieveHasNoSideEffectsOnNonEmptyCache(_ sut: FeedStore, file: StaticString = #file, line: UInt = #line) {
        let feed = uniqueImageFeed().local
        let timestamp = Date()
        
        insert((feed, timestamp), to: sut)
        
        expect(sut, toRetrieveTwice: .found(feed: feed, timestamp: timestamp))
    }
    
    func assertThatInsertDeliversNoErrorOnEmptyCache(_ sut: FeedStore, file: StaticString = #file, line: UInt = #line) {
        let insertionerror = insert((uniqueImageFeed().local, Date()), to: sut)
        XCTAssertNil(insertionerror, "Expected to insert cache successfully")
    }
    
    func assertThatInsertDeliversNoErrorOnNonEmptyCache(_ sut: FeedStore, file: StaticString = #file, line: UInt = #line) {
        let feed = uniqueImageFeed().local
        let timestamp = Date()
        
        insert((feed, timestamp), to: sut)
        
        let latestFeed = uniqueImageFeed().local
        let latestTimestamp = Date()
        let latestInsertionError = insert((latestFeed, latestTimestamp), to: sut)
        
        XCTAssertNil(latestInsertionError, "Expected to override cache successfully")
    }
    
    func assertThatInsertOverridesPreviouslyInsertedCacheValues(_ sut: FeedStore, file: StaticString = #file, line: UInt = #line) {
        let feed = uniqueImageFeed().local
        let timestamp = Date()
        
        insert((feed, timestamp), to: sut)
        
        let latestFeed = uniqueImageFeed().local
        let latestTimestamp = Date()
        insert((latestFeed, latestTimestamp), to: sut)
        
        expect(sut, toRetrieve: .found(feed: latestFeed, timestamp: latestTimestamp))
    }
    
    func assertThatDeleteDeliversNoErrorOnEmptyCache(_ sut: FeedStore, file: StaticString = #file, line: UInt = #line) {
        let deletionError = delete(in: sut)
        XCTAssertNil(deletionError, "Expected empty cache deletion to succeed")
    }
    
    func assertThatDeleteHasNoSideEffectsOnEmptyCache(_ sut: FeedStore, file: StaticString = #file, line: UInt = #line) {
        delete(in: sut)
        
        expect(sut, toRetrieve: .empty)
    }
    
    func assertThatDeleteDeliversNoErrorOnNonEmptyCache(_ sut: FeedStore, file: StaticString = #file, line: UInt = #line) {
        insert((uniqueImageFeed().local, Date()), to: sut)
        
        let deletionError = delete(in: sut)
        XCTAssertNil(deletionError, "Expected non empty cache deletion to succeed")
    }
    
    func assertThatDeleteDeletesCacheOnNonEmptyCache(_ sut: FeedStore, file: StaticString = #file, line: UInt = #line) {
        insert((uniqueImageFeed().local, Date()), to: sut)
        
        delete(in: sut)
        
        expect(sut, toRetrieve: .empty)
    }
    
    func assertThatSideEffectsRunSerially(on sut : FeedStore, file: StaticString = #file, line: UInt = #line) {
        let feed = uniqueImageFeed().local
        let timestamp = Date()
        var completedOperationsInOrder = [XCTestExpectation]()
        
        let op1 = expectation(description: "Operation 1")
        sut.insert(feed, timestamp: timestamp) { _ in
            completedOperationsInOrder.append(op1)
            op1.fulfill()
        }
        
        let op2 = expectation(description: "Operation 2")
        sut.deleteCachedFeed { _ in
            completedOperationsInOrder.append(op2)
            op2.fulfill()
        }
        
        let op3 = expectation(description: "Operation 3")
        sut.insert(feed, timestamp: timestamp) { _ in
            completedOperationsInOrder.append(op3)
            op3.fulfill()
        }
        waitForExpectations(timeout: 5.0)
        XCTAssertEqual(completedOperationsInOrder, [op1, op2, op3], "Expected side-effects run serially, but operations finished in the wrong order!")
    }
    
    
    @discardableResult
    func insert(_ cache: (feed: [LocalFeedImage], timestamp: Date), to sut: FeedStore) -> Error? {
        let exp = expectation(description: "Wait for cache retrieval")
        var insertionError: Error?
        sut.insert(cache.feed, timestamp: cache.timestamp) { receivedInsertionError in
            insertionError = receivedInsertionError
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1.0)
        return insertionError
    }
    @discardableResult
    func delete(in sut: FeedStore) -> Error? {
        let exp = expectation(description: "Wait for cache retrieval")
        var deletionError: Error?
        sut.deleteCachedFeed { receivedDeletionError in
            deletionError = receivedDeletionError
            exp.fulfill()
        }
        wait(for: [exp], timeout: 2.0)
        return deletionError
    }
    
    func expect(_ sut: FeedStore, toRetrieveTwice expectedResult: RetrievalCachedFeedResult, file: StaticString = #file, line: UInt = #line) {
        expect(sut, toRetrieve: expectedResult, file: file, line: line)
        expect(sut, toRetrieve: expectedResult, file: file, line: line)
    }
    
    func expect(_ sut: FeedStore, toRetrieve expectedResult: RetrievalCachedFeedResult, file: StaticString = #file, line: UInt = #line) {
        let exp = expectation(description: "Wait for cache retrieval")
        
        sut.retrieve { retrieveResult in
            switch (expectedResult, retrieveResult) {
            case (.empty, .empty),
                (.failure, .failure):
                break
            case let (.found(expectedFeed, expectedTimestamp), .found(retrievedFeed, retrievedTimestamp)):
                XCTAssertEqual(expectedFeed, retrievedFeed, file: file, line: line)
                XCTAssertEqual(expectedTimestamp, retrievedTimestamp, file: file, line: line)
            default:
                XCTFail("Expected to retrieve \(expectedResult), got \(retrieveResult) instead", file: file, line: line)
            }
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1.0)
    }
}
