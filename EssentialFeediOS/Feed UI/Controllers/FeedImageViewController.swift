//
//  FeedCellViewController.swift
//  EssentialFeediOS
//
//  Created by Temur on 31/01/2024.
//

import UIKit
import EssentialFeedMacos
public protocol FeedImageCellControllerDelegate {
    func didRequestImage()
    func didCancelImageRequest()
}
public final class FeedImageCellController: FeedImageView, ResourceView, ResourceLoadingView, ResourceErrorView {
    
    public typealias ResourceViewModel = UIImage
    public let viewModel: FeedImageViewModel<UIImage>
    public var delegate: FeedImageCellControllerDelegate
    private var cell: FeedImageCell?
    
    public init(viewModel: FeedImageViewModel<UIImage>, delegate: FeedImageCellControllerDelegate) {
        self.delegate = delegate
        self.viewModel = viewModel
    }
    
    func view(in tableView: UITableView) -> UITableViewCell {
        cell = tableView.dequeueReusableCell()
        cell?.locationContainer.isHidden = !viewModel.hasLocation
        cell?.locationLabel.text = viewModel.location
        cell?.descriptionLabel.text = viewModel.description
        
        cell?.onRetry = delegate.didRequestImage

//        cell?.onReuse = { [weak self] in
//            self?.releaseCellForReuse()
//        }
        delegate.didRequestImage()
        return cell!
    }
    
    func preload() {
        delegate.didRequestImage()
    }
    
    func cancelLoad() {
        releaseCellForReuse()
        delegate.didCancelImageRequest()
    }
    
    public func display(_ viewModel: FeedImageViewModel<UIImage>) {
        cell?.onRetry = delegate.didRequestImage
    }
    
    public func display(_ viewModel: UIImage) {
        cell?.feedImageView.setAnimatedImage(viewModel)
    }
    
    public func display(_ viewModel: ResourceLoadingViewModel) {
        cell?.feedImageContainer.isShimmering = viewModel.isLoading
    }
    
    public func display(_ viewModel: ResourceErrorViewModel) {
        cell?.feedImageRetryButton.isHidden = viewModel.message != nil
    }
    
    private func releaseCellForReuse() {
        cell?.onReuse = nil
        cell = nil
    }
}
