//
//  LoadResourcePresenter.swift
//  EssentialFeedMacos
//
//  Created by Temur on 23/09/2024.
//

import Foundation
public protocol ResourceView {
    func display(_ viewModel: String)
}
public class LoadResourcePresenter {
    public typealias Mapper = (String) -> String
    private let loadingView: FeedLoadingView
    private let errorView: FeedErrorView
    private let resourceView: ResourceView
    private let mapper: Mapper
    
    public init(errorView: FeedErrorView, loadingView: FeedLoadingView, resourceView: ResourceView , mapper: @escaping Mapper) {
        self.errorView = errorView
        self.loadingView = loadingView
        self.resourceView = resourceView
        self.mapper = mapper
    }
    
    public func didStartLoading() {
        errorView.display(.noError)
        loadingView.display(FeedLoadingViewModel(isLoading: true))
    }
    
    public func didFinishLoading(with resource: String) {
        resourceView.display(mapper(resource))
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
