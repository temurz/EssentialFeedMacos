//
//  LocalFeedLoader.swift
//  EssentialFeedMacos
//
//  Created by Temur on 07/11/2023.
//

import Foundation

public final class LocalFeedLoader {
    private let store: FeedStore
    private let currentDate: () -> Date
    
    public typealias SaveResult = Error?
    public init(store: FeedStore, currentDate: @escaping () -> Date) {
        self.store = store
        self.currentDate = currentDate
    }
    
    public func save(_ items: [FeedItem], completion: @escaping (SaveResult) -> ()) {
        store.deleteCachedFeed { [weak self] error in
            guard let self else {return}
            if let cacheDeletionerror = error {
                completion(cacheDeletionerror)
            }else {
                cache(items, completion: completion)
            }
        }
    }
    
    private func cache(_ items: [FeedItem], completion: @escaping (SaveResult ) -> ()) {
        store.insert(items.toLocal(), timestamp: currentDate()) { [weak self] error in
            guard self != nil else { return }
            completion(error)
        }
    }
}

private extension Array where Element == FeedItem {
    func toLocal() -> [LocalFeedItem] {
        return map { LocalFeedItem(id: $0.id, description: $0.description, location: $0.location, imageURL: $0.imageURL)}
    }
}



