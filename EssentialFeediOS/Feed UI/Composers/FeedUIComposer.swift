//
//  FeedUIComposer.swift
//  EssentialFeediOS
//
//  Created by Temur on 31/01/2024.
//

import UIKit
import EssentialFeedMacos
import EssentialFeediOS
import Combine
public final class FeedUIComposer {
    private init() {}
    
//    public static func feedComposeWith(feedLoader: FeedLoader, imageLoader: FeedImageDataLoader) -> FeedViewController {
//        let presentationAdapter = FeedLoaderPresentationAdapter(feedLoader: MainQueueDispatchDecorator(decoratee: feedLoader))
//        
//        let feedController = makeWith(delegate: presentationAdapter, title: FeedPresenter.title)
//        
//        
//        presentationAdapter.presenter = FeedPresenter(
//            errorView: WeakRefVirtualProxy(object: feedController),
//            loadingView: WeakRefVirtualProxy(object: feedController),
//            feedView: FeedViewAdapter(controller: feedController,
//                                    imageLoader: MainQueueDispatchDecorator(decoratee: imageLoader)))
//        return feedController
//    }
    
    public static func feedComposeWith(feedLoader: @escaping () -> AnyPublisher<[FeedImage], Error>, imageLoader: @escaping (URL) -> FeedImageDataLoader.Publisher) -> ListViewController {
        let presentationAdapter = LoadResourcePresentationAdapter<[FeedImage], FeedViewAdapter>(loader: { feedLoader().dispatchOnMainQueue() })
        
        let feedController = makeWith(title: FeedPresenter.title)
        feedController.onRefresh = presentationAdapter.loadResource
        
        presentationAdapter.presenter = LoadResourcePresenter(
            errorView: WeakRefVirtualProxy(feedController),
            loadingView: WeakRefVirtualProxy(feedController),
            resourceView: FeedViewAdapter(controller: feedController,
                                          imageLoader: { imageLoader($0).dispatchOnMainQueue() }), mapper: FeedPresenter.map(_:))
        return feedController
    }
    
    private static func makeWith(title: String) -> ListViewController {
        let bundle = Bundle(for: ListViewController.self)
        let storyboard = UIStoryboard(name: "Feed", bundle: bundle)
        let feedController = storyboard.instantiateInitialViewController() as! ListViewController
//        feedController.delegate = delegate
        feedController.title = title
        return feedController
    }
}
