//
//  FeedUIComposer.swift
//  EssentialFeediOS
//
//  Created by Temur on 31/01/2024.
//

import EssentialFeedMacos
public final class FeedUIComposer {
    private init() {}
    
    public static func feedComposeWith(feedLoader: FeedLoader, imageLoader: FeedImageDataLoader) -> FeedViewController {
        let refrehController = FeedRefreshViewController(feedLoader: feedLoader)
        let feedController = FeedViewController(refreshController: refrehController)
        refrehController.onRefresh = adaptFeedToCellControllers(forwardingTo: feedController, loader: imageLoader)  
        return feedController
    }
    
    private static func adaptFeedToCellControllers(forwardingTo controller: FeedViewController, loader: FeedImageDataLoader) -> ([FeedImage]) -> Void {
        return { [weak controller] feed in
            controller?.tableModel = feed.map { model in
                FeedImageCellController(model: model, imageLoader: loader)
            }
        }
    }
}
