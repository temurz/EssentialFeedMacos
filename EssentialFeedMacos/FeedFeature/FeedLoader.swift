//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by Temur on 19/06/2023.
//

import Foundation

public protocol FeedLoader {
    typealias LoadFeedResult = Swift.Result<[FeedImage], Error>
    func load(completion: @escaping (LoadFeedResult) -> Void)
}
