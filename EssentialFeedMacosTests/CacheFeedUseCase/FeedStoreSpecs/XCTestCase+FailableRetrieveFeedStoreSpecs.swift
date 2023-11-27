//
//  XCTestCase+FailableRetrieveFeedStoreSpecs.swift
//  EssentialFeedMacosTests
//
//  Created by Temur on 27/11/2023.
//

import Foundation
import XCTest
import EssentialFeedMacos
extension FailableRetrieveFeedStoreSpecs where Self: XCTestCase {
    func assertThatRetrieveDeliversErrorOnRetrievalError(_ sut: FeedStore, file: StaticString = #file, line: UInt = #line) {
        expect(sut, toRetrieve: .failure(anyNSError()))
    }
    
    func assertThatRetrieveHasNoSideEffectsOnFailure(_ sut: FeedStore, file: StaticString = #file, line: UInt = #line) {
        expect(sut, toRetrieve: .failure(anyNSError()))
    }
}
