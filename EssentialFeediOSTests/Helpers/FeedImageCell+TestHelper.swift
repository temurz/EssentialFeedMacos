//
//  FeedImageCell+TestHelper.swift
//  EssentialFeediOSTests
//
//  Created by Temur on 08/04/2024.
//

import Foundation
import EssentialFeediOS
extension FeedImageCell {
    func simulateRetryAction() {
        feedImageRetryButton.simulateTap()
    }
    var isShowingLocation: Bool {
        return !locationContainer.isHidden
    }
    
    var isShowingImageLoadingIndicator: Bool {
        return feedImageContainer.isShimmering
    }
    
    var locationText: String? {
        return locationLabel.text
    }
    
    var descriptionText: String? {
        return descriptionLabel.text
    }
    
    var renderedImage: Data? {
        return feedImageView.image?.pngData()
    }
    
    var isShowingRetryAction: Bool {
            return !feedImageRetryButton.isHidden
        }
}

