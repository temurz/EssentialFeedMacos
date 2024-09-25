//
//  ImageCommentsPresenter.swift
//  EssentialFeedMacos
//
//  Created by Temur on 25/09/2024.
//

import Foundation
public final class ImageCommentsPresenter {
    public static var title: String {
        return NSLocalizedString("IMAGE_COMMENTS_VIEW_TITLE", tableName: "ImageComments", bundle: Bundle(for: Self.self), comment: "Title for the feed view")
    }
    
    public static func map(_ feed: [FeedImage]) -> FeedViewModel {
        FeedViewModel(feed: feed)
    }
}
