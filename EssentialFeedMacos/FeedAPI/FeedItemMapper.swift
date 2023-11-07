//
//  FeedItemsMapper.swift
//  EssentialFeed
//
//  Created by Temur on 07/09/2023.
//

import Foundation

internal struct RemoteFeedItem: Decodable {
    internal let id: UUID
    internal let description: String?
    internal let location: String?
    internal let image: URL
}

final class FeedItemsMapper {
    private struct Root: Decodable {
        let items: [RemoteFeedItem]
        
    }

    
    
    private  static var OK_200: Int {return 200}
    
//    internal static func map(_ data: Data, _ response: HTTPURLResponse) throws -> [FeedItem] {
//
//        return try JSONDecoder().decode(Root.self, from: data).items.map{$0.item}
//    }
    
    internal static func map(_ data: Data, from response: HTTPURLResponse) throws -> [RemoteFeedItem] {
        guard response.statusCode == OK_200, let root = try? JSONDecoder().decode(Root.self, from: data) else {
            throw RemoteFeedLoader.Error.invalidData
        }
        return root.items
    }
}
