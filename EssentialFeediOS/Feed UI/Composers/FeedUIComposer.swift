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
        refrehController.onRefresh = { [weak feedController] feed in
            feedController?.tableModel = feed.map { model in
                FeedImageCellController(model: model, imageLoader: imageLoader)
            }
        }
        return feedController
    }
    
    
}
