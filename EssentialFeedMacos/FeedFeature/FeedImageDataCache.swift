//
//  FeedImageDataCache.swift
//  EssentialFeedMacos
//
//  Created by Temur on 07/05/2024.
//

import Foundation
public protocol FeedImageDataCache {
    typealias Result = Swift.Result<Void,Error>
    
    func save(_ data: Data, for url: URL, completion: @escaping ((Result) -> Void))
}
