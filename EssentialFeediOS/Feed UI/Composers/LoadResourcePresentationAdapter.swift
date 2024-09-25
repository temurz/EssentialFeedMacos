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
public final class LoadResourcePresentationAdapter<Resource, View: ResourceView> {
    var presenter: LoadResourcePresenter<Resource, View>?
    private var cancellable: Cancellable?
    private let loader: () -> AnyPublisher<Resource,Error>
    
    public init(loader: @escaping () -> AnyPublisher<Resource,Error>) {
        self.loader = loader
    }
    
    public func loadResource() {
        presenter?.didStartLoading()
        
        cancellable = loader().sink { [weak self] completion in
            switch completion {
            case .finished: break
            case let .failure(error):
                self?.presenter?.didFinishLoading(with: error)
            }
        } receiveValue: { [weak self] feed in
            self?.presenter?.didFinishLoading(with: feed)
        }
    }
}


//extension LoadResourcePresentationAdapter: FeedViewControllerDelegate {
//    public func didRequestFeedRefresh() {
//        loadResource()
//    }
//}

extension LoadResourcePresentationAdapter: FeedImageCellControllerDelegate {
    public func didRequestImage() {
        loadResource()
    }
    
    public func didCancelImageRequest() {
        cancellable?.cancel()
    }
}
