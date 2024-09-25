//
//  FeedImagePresenter.swift
//  EssentialFeedMacos
//
//  Created by Temur on 21/02/2024.
//

import Foundation

final public class FeedImagePresenter {
    
    public static func map(_ image: FeedImage) -> FeedImageViewModel {
        return FeedImageViewModel(
            description: image.description,
            location: image.location)
    }
    
//    public func didStartLoadingImageData(for model: FeedImage) {
//        view.display(FeedImageViewModel(
//            description: model.description,
//            location: model.location,
//            image: nil,
//            isLoading: true,
//            shouldRetry: false))
//    }
//    
//    public func didFinishLoadingImageData(with data: Data, for model: FeedImage) {
//        let image = imageTransformer(data)
//        view.display(FeedImageViewModel(
//            description: model.description,
//            location: model.location,
//            image: imageTransformer(data),
//            isLoading: false,
//            shouldRetry: image == nil))
//    }
//    
//    public func didFinishLoadingImageData(with error: Error, for model: FeedImage) {
//        view.display(FeedImageViewModel(
//            description: model.description,
//            location: model.location,
//            image: nil,
//            isLoading: false,
//            shouldRetry: true))
//    }
    
    
}
