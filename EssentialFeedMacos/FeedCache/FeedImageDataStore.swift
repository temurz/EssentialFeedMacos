//
//  FeedImageDataStore.swift
//  EssentialFeedMacos
//
//  Created by Temur on 24/02/2024.
//

import Foundation
public protocol FeedImageDataStore {
    typealias Result = Swift.Result<Data?, Error>
    
    func retrieve(dataForURL url: URL, completion: @escaping (Result) -> Void)
}
