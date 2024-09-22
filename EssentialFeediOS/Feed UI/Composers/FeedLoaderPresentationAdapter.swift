//
//  FeedLoaderPresentationAdapter.swift
//  EssentialFeediOS
//
//  Created by Temur on 09/02/2024.
//

import EssentialFeedMacos
import EssentialFeediOS
import Combine
//internal final class FeedLoaderPresentationAdapter: FeedViewControllerDelegate {
//    var presenter: FeedPresenter?
//    private let feedLoader: FeedLoader
//    
//    init(feedLoader: FeedLoader) {
//        self.feedLoader = feedLoader
//    }
//    
//    func didRequestFeedRefresh() {
//        presenter?.didStartLoadingFeed()
//        
//        feedLoader.load { [weak self] result in
//            switch result {
//            case let .success(feed):
//                self?.presenter?.didFinishLoadingFeed(with: feed)
//            case let .failure(error):
//                self?.presenter?.didFinishLoadingFeed(with: error)
//            }
//        }
//    }
//}
public final class FeedLoaderPresentationAdapter: FeedViewControllerDelegate {
    var presenter: FeedPresenter?
    private var cancellable: Cancellable?
    private let feedLoader: () -> AnyPublisher<[FeedImage],Error>
    
    public init(feedLoader: @escaping () -> AnyPublisher<[FeedImage],Error>) {
        self.feedLoader = feedLoader
    }
    
    public func didRequestFeedRefresh() {
        presenter?.didStartLoadingFeed()
        
        cancellable = feedLoader().sink { [weak self] completion in
            switch completion {
            case .finished: break
            case let .failure(error):
                self?.presenter?.didFinishLoadingFeed(with: error)
            }
        } receiveValue: { [weak self] feed in
            self?.presenter?.didFinishLoadingFeed(with: feed)
        }
    }
}
