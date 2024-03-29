//
//  SharedTestHelpers.swift
//  EssentialFeedMacosTests
//
//  Created by Temur on 13/11/2023.
//

import Foundation

func anyNSError() -> NSError {
    return NSError(domain: "any error", code: 0)
}

func anyURL() -> URL {
    return URL(string: "http://any-url.com")!
}

func anyData() -> Data { return Data() }
