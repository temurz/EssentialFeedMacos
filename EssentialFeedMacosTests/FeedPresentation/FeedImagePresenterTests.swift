//
//  FeedImagePresenterTests.swift
//  EssentialFeedMacosTests
//
//  Created by Temur on 21/02/2024.
//

import XCTest
import EssentialFeedMacos

class FeedImagePresenterTests: XCTestCase {
    
    func test_map_createsViewModel() {
        let image = uniqueImage()
        
        let viewModel = FeedImagePresenter.map(image)
        
        XCTAssertEqual(viewModel.description, image.description)
        XCTAssertEqual(viewModel.location, image.location)
    }
}
