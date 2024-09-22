//
//  MainQueueDispatchDecorator.swift
//  EssentialFeediOS
//
//  Created by Temur on 09/02/2024.
//

import Foundation
import EssentialFeedMacos
internal final class MainQueueDispatchDecorator<T> {
    private let decoratee: T
    
    init(decoratee: T) {
        self.decoratee = decoratee
    }
    
    func dispatch(completion: @escaping () -> Void) {
        guard Thread.isMainThread else {
            return DispatchQueue.main.async(execute: completion)
        }
        completion()
    }
}

//extension MainQueueDispatchDecorator: FeedLoader where T == FeedLoader {
//    func load(completion: @escaping (Swift.Result<[FeedImage], Error>) -> Void) {
//        decoratee.load { [weak self] result in
//            self?.dispatch {
//                completion(result)
//            }
//        }
//    }
//}
//
//extension MainQueueDispatchDecorator: FeedImageDataLoader where T == FeedImageDataLoader {
//    func loadImageData(from url: URL, completion: @escaping (FeedImageDataLoader.Result) -> Void) -> FeedImageDataLoaderTask {
//        decoratee.loadImageData(from: url) { [weak self] result in
//            self?.dispatch { completion(result) }
//        }
//    }
//}
