//
//  LoadResourcePresenter.swift
//  EssentialFeedMacos
//
//  Created by Temur on 23/09/2024.
//

import Foundation
public class LoadResourcePresenter {
    private let loadingView: FeedLoadingView
    private let errorView: FeedErrorView
    private let feedView: FeedView
    
    public init(errorView: FeedErrorView, loadingView: FeedLoadingView, feedView: FeedView) {
        self.errorView = errorView
        self.loadingView = loadingView
        self.feedView = feedView
    }
    
    public func didStartLoadingFeed() {
        errorView.display(.noError)
        loadingView.display(FeedLoadingViewModel(isLoading: true))
    }
    
    public func didFinishLoadingFeed(with feed: [FeedImage]) {
        feedView.display(FeedViewModel(feed: feed))
        loadingView.display(FeedLoadingViewModel(isLoading: false))
    }
    
    public func didFinishLoadingFeed(with error: Error) {
        loadingView.display(FeedLoadingViewModel(isLoading: false))
        errorView.display(FeedErrorViewModel(message: feedError))
    }
    
    private var feedError: String {
        return NSLocalizedString("FEED_VIEW_CONNECTION_ERROR", tableName: "Feed", bundle: Bundle(for: FeedPresenter.self) , comment: "Error message displayed when we cannot load the image feed from the server")
    }
}
