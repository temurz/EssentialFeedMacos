//
//  FeedItem.swift
//  EssentialFeed
//
//  Created by Temur on 19/06/2023.
//

import Foundation

public struct FeedImage: Hashable {
    public let id: UUID
    public let description: String?
    public let location: String?
    public let imageURL: URL
    
    public init(id: UUID, description: String?, location: String?, imageURL: URL) {
        self.id = id
        self.description = description
        self.location = location
        self.imageURL = imageURL
    }
}
