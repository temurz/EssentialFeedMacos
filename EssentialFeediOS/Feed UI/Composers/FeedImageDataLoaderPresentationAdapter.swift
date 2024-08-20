//
//  FeedImageDataLoaderPresentationAdapter.swift
//  EssentialFeediOS
//
//  Created by Temur on 09/02/2024.
//

import UIKit
import EssentialFeedMacos
import EssentialFeediOS
import Combine
internal final class FeedImageDataLoaderPresentationAdapter<View: FeedImageView, Image>: FeedImageCellControllerDelegate where View.Image == UIImage {
    private let model: FeedImage
    private let imageLoader: (URL) -> FeedImageDataLoader.Publisher
//    var task: FeedImageDataLoaderTask?
    private var cancellable: Cancellable?
    
    var presenter: FeedImagePresenter<View,UIImage>?
    
    init(model: FeedImage, imageLoader: @escaping (URL) -> FeedImageDataLoader.Publisher) {
        self.model = model
        self.imageLoader = imageLoader
    }
    
    func didRequestImage() {
        presenter?.didStartLoadingImageData(for: model)
        let model = self.model
        
        cancellable = imageLoader(model.imageURL).sink { [weak self] completion in
            switch completion {
            case .finished: break
            case let .failure(error):
                self?.presenter?.didFinishLoadingImageData(with: error, for: model)
            }
        } receiveValue: { [weak self] data in
            self?.presenter?.didFinishLoadingImageData(with: data, for: model)
        }

        
//        task = imageLoader.loadImageData(from: model.imageURL, completion: { [weak self] result in
//            switch result {
//            case let .success(data):
//                self?.presenter?.didFinishLoadingImageData(with: data, for: model)
//            case let .failure(error):
//                self?.presenter?.didFinishLoadingImageData(with: error, for: model)
//            }
//        })
    }
    
    func didCancelImageRequest() {
        cancellable?.cancel()
    }
}
