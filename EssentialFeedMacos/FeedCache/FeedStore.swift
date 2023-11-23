//
//  FeedStore.swift
//  EssentialFeedMacos
//
//  Created by Temur on 07/11/2023.
//

import Foundation

public enum RetrievalCachedFeedResult {
    case empty
    case found(feed: [LocalFeedImage], timestamp: Date)
    case failure(Error)
}

public protocol FeedStore {
    typealias DeletionCompletion = (Error?) -> Void
    typealias InsertionCompletion = (Error?) -> Void
    typealias RetrievalCompletion = (RetrievalCachedFeedResult) -> Void
    
    ///The completion handler can be invoked in any thread.
    ///Clients are responsible to dispatch to appropriate threads, if needed.
    func deleteCachedFeed(completion: @escaping DeletionCompletion)
    
    ///The completion handler can be invoked in any thread.
    ///Clients are responsible to dispatch to appropriate threads, if needed.
    func insert(_ feed: [LocalFeedImage], timestamp: Date, completion: @escaping InsertionCompletion)
    
    ///The completion handler can be invoked in any thread.
    ///Clients are responsible to dispatch to appropriate threads, if needed.
    func retrieve(completion: @escaping RetrievalCompletion)
}
