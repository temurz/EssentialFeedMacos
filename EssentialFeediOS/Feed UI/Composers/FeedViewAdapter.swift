//
//  FeedViewAdapter.swift
//  EssentialFeediOS
//
//  Created by Temur on 09/02/2024.
//

import UIKit
import EssentialFeedMacos
import EssentialFeediOS
internal final class FeedViewAdapter: ResourceView {
    private weak var controller: ListViewController?
    private let imageLoader: (URL) -> FeedImageDataLoader.Publisher
    
    init(controller: ListViewController, imageLoader: @escaping (URL) -> FeedImageDataLoader.Publisher) {
        self.controller = controller
        self.imageLoader = imageLoader
    }
    
    func display(_ viewModel: FeedViewModel) {
        controller?.display(viewModel.feed.map({ model in
            let adapter = LoadResourcePresentationAdapter<Data, WeakRefVirtualProxy<FeedImageCellController>> {
                [imageLoader] in imageLoader(model.imageURL)
            }
            let view = FeedImageCellController(viewModel: FeedImagePresenter.map(model), delegate: adapter)
            adapter.presenter = LoadResourcePresenter(
                errorView: WeakRefVirtualProxy(view),
                loadingView: WeakRefVirtualProxy(view),
                resourceView: WeakRefVirtualProxy(view),
                mapper: { data in
                    guard let image = UIImage(data: data) else {
                        throw InvalidImageData()
                    }
                    return image
                })
            return view
        }))
    }
}

private struct InvalidImageData: Error {}
