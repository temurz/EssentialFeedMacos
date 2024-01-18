//
//  FeedImageCell.swift
//  EssentialFeediOS
//
//  Created by Temur on 13/01/2024.
//

import UIKit
public final class FeedImageCell: UITableViewCell {
    public let locationContainer = UIView()
    public let locationLabel = UILabel()
    public let descriptionLabel = UILabel()
    public let feedImageContainer = UIView()
    public let feedImageView = UIImageView()
    public let feedImageRetryButton: UIButton = UIButton()
//    public var feedImageRetryButton: UIButton {
//        let button = UIButton()
//        button.addTarget(self, action: #selector(retryButtonTapped), for: .touchUpInside)
//        return button
//    }
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        feedImageRetryButton.addTarget(self, action: #selector(retryButtonTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    var onRetry: (() -> Void)?
    
    @objc private func retryButtonTapped() {
        onRetry?()
    }
    
    
}
