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
    
    public static func feedComposeWith(feedLoader: @escaping () -> AnyPublisher<[FeedImage], Error>, imageLoader: @escaping (URL) -> FeedImageDataLoader.Publisher) -> FeedViewController {
        let presentationAdapter = FeedLoaderPresentationAdapter(feedLoader: { feedLoader().dispatchOnMainQueue() })
        
        let feedController = makeWith(delegate: presentationAdapter, title: FeedPresenter.title)
        
        
        presentationAdapter.presenter = LoadResourcePresenter(
            errorView: WeakRefVirtualProxy(object: feedController),
            loadingView: WeakRefVirtualProxy(object: feedController),
            resourceView: FeedViewAdapter(controller: feedController,
                                          imageLoader: { imageLoader($0).dispatchOnMainQueue() }), mapper: FeedPresenter.map(_:))
        return feedController
    }
    
    private static func makeWith(delegate: FeedViewControllerDelegate, title: String) -> FeedViewController {
        let bundle = Bundle(for: FeedViewController.self)
        let storyboard = UIStoryboard(name: "Feed", bundle: bundle)
        let feedController = storyboard.instantiateInitialViewController() as! FeedViewController
        feedController.delegate = delegate
        feedController.title = title
        return feedController
    }
}
