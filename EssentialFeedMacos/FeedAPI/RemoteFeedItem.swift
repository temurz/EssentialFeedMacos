//
//  RemoteFeedItem.swift
//  EssentialFeedMacos
//
//  Created by Temur on 07/11/2023.
//

import Foundation

internal struct RemoteFeedItem: Decodable {
    internal let id: UUID
    internal let description: String?
    internal let location: String?
    internal let image: URL
}
