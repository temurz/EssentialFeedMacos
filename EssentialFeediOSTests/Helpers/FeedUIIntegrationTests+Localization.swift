//
//  FeedUIIntegrationTests+Localization.swift
//  EssentialFeediOSTests
//
//  Created by Temur on 08/04/2024.
//

import EssentialFeedMacos
import Foundation
import XCTest
extension FeedUIIntegrationTests {
    func localized(_ key: String, file: StaticString = #file, line: UInt = #line) -> String {
        let table = "Feed"
        let bundle = Bundle(for: FeedPresenter.self)
        let value = bundle.localizedString(forKey: key, value: nil, table: table)
        if value == key {
            XCTFail("Missing localized string for key: \(key) in table: \(table)", file: file, line: line)
        }
        return value
    }
}
