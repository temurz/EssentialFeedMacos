//
//  LocalFeedLoader.swift
//  EssentialFeedMacos
//
//  Created by Temur on 07/11/2023.
//

import Foundation



//Controller or Interactor or Control boundary or Model controller
public final class LocalFeedLoader {
    private let store: FeedStore
    private let currentDate: () -> Date
    private let calendar = Calendar(identifier: .gregorian)
    
    public init(store: FeedStore, currentDate: @escaping () -> Date) {
        self.store = store
        self.currentDate = currentDate
    }
}

extension LocalFeedLoader {
    public typealias SaveResult = Error?
    public func save(_ feed: [FeedImage], completion: @escaping (SaveResult) -> ()) {
        store.deleteCachedFeed { [weak self] error in
            guard let self else {return}
            switch error {
            case .success:
                cache(feed, completion: completion)
            case let .failure(error):
                completion(error)
            }
        }
    }
    
    private func cache(_ feed: [FeedImage], completion: @escaping (SaveResult ) -> ()) {
        store.insert(feed.toLocal(), timestamp: currentDate()) { [weak self] error in
            guard self != nil else { return }
            switch error {
            case let .failure(error):
                completion(error)
            case .success:
                completion(nil)
            }
        }
    }
}

extension LocalFeedLoader: FeedLoader {
    public typealias LoadResult = FeedLoader.Result
    public func load(completion: @escaping (LoadResult) -> Void) {
        store.retrieve { [weak self] result in
            guard let self else { return }
            
            switch result {
            case let .failure(error):
                completion(.failure(error))
            case let .success(.some((feed, timestamp))) where FeedCachePolicy.validate(timestamp, against: currentDate()):
                completion(.success(feed.toModels()))
            case .success:
                completion(.success([]))
            }
        }
    }
}

extension LocalFeedLoader {
    public typealias ValidationResult = Result<Void, Error>
    public func validateCache(completion: @escaping (ValidationResult) -> Void) {
        store.retrieve { [weak self] result in
            guard let self else { return }
            switch result {
            case .failure:
                self.store.deleteCachedFeed(completion: completion)
            case let .success(.some((_, timestamp: timestamp))) where FeedCachePolicy.validate(timestamp, against: currentDate()):
                completion(.success(()))
            case .success:
                self.store.deleteCachedFeed { _ in  completion(.success(()))}
            }
        }
    }
}

private extension Array where Element == FeedImage {
    func toLocal() -> [LocalFeedImage] {
        return map { LocalFeedImage(id: $0.id, description: $0.description, location: $0.location, url: $0.imageURL)}
    }
}

private extension Array where Element == LocalFeedImage {
    func toModels() -> [FeedImage] {
        return map { FeedImage(id: $0.id, description: $0.description, location: $0.location, imageURL: $0.url)}
    }
}


