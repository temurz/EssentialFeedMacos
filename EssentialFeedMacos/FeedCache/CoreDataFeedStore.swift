//
//  CoreDataFeedStore.swift
//  EssentialFeedMacos
//
//  Created by Temur on 27/11/2023.
//

import Foundation

public class CoreDataFeedStore: FeedStore {
    
    public init() {
        
    }
    
    public func retrieve(completion: @escaping RetrievalCompletion) {
        completion(.empty)
    }
    
    public func deleteCachedFeed(completion: @escaping DeletionCompletion) {
        
    }
    
    public func insert(_ feed: [LocalFeedImage], timestamp: Date, completion: @escaping InsertionCompletion) {
        
    }
    
}
