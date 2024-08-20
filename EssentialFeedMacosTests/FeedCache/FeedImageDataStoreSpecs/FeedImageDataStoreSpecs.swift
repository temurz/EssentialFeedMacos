//
//  FeedImageDataStoreSpecs.swift
//  EssentialFeedMacosTests
//
//  Created by Temur on 14/05/2024.
//

import Foundation
protocol FeedImageDataStoreSpecs {
    func test_retrieveImageData_deliversNotFoundWhenEmpty() throws
    func test_retrieveImageData_deliversNotFoundWhenStoredDataURLDoesNotMatch() throws
    func test_retrieveImageData_deliversFoundDataWhenThereIsAStoredImageDataMatchingURL() throws
    func test_retrieveImageData_deliversLastInsertedValue() throws
}
