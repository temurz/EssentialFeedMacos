//
//  RemoteFeedLoader.swift
//  EssentialFeed
//
//  Created by Temur on 14/07/2023.
//

import Foundation



public class RemoteFeedLoader: FeedLoader {
    private let client: HTTPClient
    private let url: URL
    public init(url: URL = URL(string: "https://a-url.com")!, client: HTTPClient) {
        self.url = url
        self.client = client
    }
    
    public enum Error: Swift.Error {
        case connectivity
        case invalidData
    }
    
    public typealias Result = LoadFeedResult
    
    public func load(completion: @escaping (Result) -> Void) {
        client.get(from: url) { [weak self] result  in
            guard self != nil else { return }
            switch result {
            case let .success(data, response):
                completion(FeedItemsMapper.map(data, from: response))
            case .failure:
                completion(.failure(Error.connectivity))
            }
        }
    }
}

