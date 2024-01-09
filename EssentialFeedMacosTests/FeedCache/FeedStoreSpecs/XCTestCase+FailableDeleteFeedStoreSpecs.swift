//
//  XCTestCase+FailableDeleteFeedStoreSpecs.swift
//  EssentialFeedMacosTests
//
//  Created by Temur on 27/11/2023.
//

import Foundation
import XCTest
import EssentialFeedMacos
extension FailableDeleteFeedStoreSpecs where Self: XCTestCase{
    func assertThatDeleteDeliversErrorOnDeletionError(_ sut: FeedStore, file: StaticString = #file, line: UInt = #line) {
        let deletionError = delete(in: sut)
        XCTAssertNotNil(deletionError, "Expected to deliver an error on deletion error")
    }
    
    func assertThatDeleteHasNoSideEffectsOnDeletionError(_ sut: FeedStore, file: StaticString = #file, line: UInt = #line) {
        
        delete(in: sut)
        
        expect(sut, toRetrieve: .success(.empty))
    }
}
