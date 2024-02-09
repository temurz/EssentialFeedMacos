//
//  FeedPresenter.swift
//  EssentialFeediOS
//
//  Created by Temur on 06/02/2024.
//

import EssentialFeedMacos
struct FeedViewModel {
    let feed: [FeedImage]
}
protocol FeedView {
    func display(_ viewModel: FeedViewModel)
}

struct FeedLoadingViewModel {
    let isLoading: Bool
}
protocol FeedLoadingView {
    func display(_ viewModel: FeedLoadingViewModel)
}

final class FeedPresenter {
    
    private let feedView: FeedView
    private let loadingView: FeedLoadingView
    
    static var title: String {
        return "My Feed"
    }
    init(feedView: FeedView, loadingView: FeedLoadingView) {
        self.feedView = feedView
        self.loadingView = loadingView
    }
    
    func didStartLoadingFeed() {
        loadingView.display(FeedLoadingViewModel(isLoading: true))
    }
    
    func didFinishLoadingFeed(with feed: [FeedImage]) {
        feedView.display(FeedViewModel(feed: feed))
        loadingView.display(FeedLoadingViewModel(isLoading: false))
    }
    
    func didFinishLoadingFeed(with error: Error) {
        loadingView.display(FeedLoadingViewModel(isLoading: false))
    }
}
