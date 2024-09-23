//
//  SharedLocalizationTests.swift
//  EssentialFeedMacosTests
//
//  Created by Temur on 23/09/2024.
//

import XCTest
import EssentialFeedMacos
class SharedLocalizationTests: XCTestCase {
    
    func test_localizedStrings_haveKeysAndValuesForAllSupportedLocalizations() {
        let table = "Shared"
        let presentationBundle = Bundle(for: LoadResourcePresenter<Any, DummyView>.self)
        assertLocalizedKeyAndValuesExist(in: presentationBundle, table)
    }
    
    private class DummyView: ResourceView {
        func display(_ viewModel: Any) {
            
        }
    }
}
