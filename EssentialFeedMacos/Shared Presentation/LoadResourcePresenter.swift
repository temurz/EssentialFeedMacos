//
//  LoadResourcePresenter.swift
//  EssentialFeedMacos
//
//  Created by Temur on 23/09/2024.
//

import Foundation
public protocol ResourceView {
    associatedtype ResourceViewModel
    func display(_ viewModel: ResourceViewModel)
}
public class LoadResourcePresenter<Resource, View: ResourceView> {
    public typealias Mapper = (Resource) -> View.ResourceViewModel
    
    private let loadingView: FeedLoadingView
    private let errorView: FeedErrorView
    private let resourceView: View
    private let mapper: Mapper
    
    public init(errorView: FeedErrorView, loadingView: FeedLoadingView, resourceView: View , mapper: @escaping Mapper) {
        self.errorView = errorView
        self.loadingView = loadingView
        self.resourceView = resourceView
        self.mapper = mapper
    }
    
    public func didStartLoading() {
        errorView.display(.noError)
        loadingView.display(FeedLoadingViewModel(isLoading: true))
    }
    
    public func didFinishLoading(with resource: Resource) {
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
