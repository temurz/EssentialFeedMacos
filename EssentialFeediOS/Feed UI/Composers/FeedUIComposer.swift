//
//  FeedUIComposer.swift
//  EssentialFeediOS
//
//  Created by Temur on 31/01/2024.
//

import UIKit
import EssentialFeedMacos
import EssentialFeediOS
public final class FeedUIComposer {
    private init() {}
    
    public static func feedComposeWith(feedLoader: FeedLoader, imageLoader: FeedImageDataLoader) -> FeedViewController {
        let presentationAdapter = FeedLoaderPresentationAdapter(feedLoader: MainQueueDispatchDecorator(decoratee: feedLoader))
        
        let feedController = makeWith(delegate: presentationAdapter, title: FeedPresenter.title)
        
        
        presentationAdapter.presenter = FeedPresenter(
            errorView: WeakRefVirtualProxy(object: feedController),
            loadingView: WeakRefVirtualProxy(object: feedController),
            feedView: FeedViewAdapter(controller: feedController,
                                    imageLoader: MainQueueDispatchDecorator(decoratee: imageLoader)))
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
