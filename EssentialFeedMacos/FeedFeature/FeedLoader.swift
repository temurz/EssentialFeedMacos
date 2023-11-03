//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by Temur on 19/06/2023.
//

import Foundation

public enum LoadFeedResult {
    case success([FeedItem])
    case failure(Error)
}

public protocol FeedLoader {
    func load(completion: @escaping (LoadFeedResult) -> Void)
}
