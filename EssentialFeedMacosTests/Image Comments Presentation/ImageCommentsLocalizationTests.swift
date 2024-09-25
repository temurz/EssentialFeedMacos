//
//  ImageCommentsLocalizationTests.swift
//  EssentialFeedMacosTests
//
//  Created by Temur on 25/09/2024.
//

import Foundation
import XCTest
import EssentialFeedMacos
class ImageCommentsLocalizationTests: XCTestCase {
    func test_localizedStrings_haveKeysAndValuesForAllSupportedLocalizations() {
        let table = "ImageComments"
        let presentationBundle = Bundle(for: ImageCommentsPresenter.self)
        assertLocalizedKeyAndValuesExist(in: presentationBundle, table)
    }
    
}
