//
//  FeedItemsMapper.swift
//  EssentialFeed
//
//  Created by Temur on 07/09/2023.
//

import Foundation
public final class FeedItemsMapper {
    private struct Root: Decodable {
        private let items: [RemoteFeedItem]
        
        private struct RemoteFeedItem: Decodable {
            internal let id: UUID
            internal let description: String?
            internal let location: String?
            internal let image: URL
        }
        
        var images: [FeedImage] {
            items.map { FeedImage(id: $0.id, description: $0.description, location: $0.location, imageURL: $0.image) }
        }
    }
    
    public enum Error: Swift.Error {
        case invalidData
    }
    
    private  static var OK_200: Int {return 200}
    public static func map(_ data: Data, from response: HTTPURLResponse) throws -> [FeedImage] {
        guard response.statusCode == OK_200, let root = try? JSONDecoder().decode(Root.self, from: data) else {
            throw Error.invalidData
        }
        return root.images
    }
}
