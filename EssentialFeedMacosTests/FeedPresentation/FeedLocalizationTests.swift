//
//  FeedLocalizationTests.swift
//  EssentialFeediOSTests
//
//  Created by Temur on 09/02/2024.
//

import Foundation
import XCTest 
@testable import EssentialFeedMacos

final class FeedLocalizationTests: XCTestCase {

    func test_localizedStrings_haveKeysAndValuesForAllSupportedLocalizations() {
        let table = "Feed"
        let bundle = Bundle(for: FeedPresenter.self)
        assertLocalizedKeyAndValuesExist(in: bundle, table)
    }
}
