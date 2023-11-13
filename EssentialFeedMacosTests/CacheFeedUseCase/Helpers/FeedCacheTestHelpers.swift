//
//  FeedCacheTestHelpers.swift
//  EssentialFeedMacosTests
//
//  Created by Temur on 13/11/2023.
//

import EssentialFeedMacos
 
func uniqueImage() -> FeedImage {
    return FeedImage(id: UUID(),
                    description: nil,
                    location: nil,
                    imageURL: anyUrl() )
}

func uniqueImageFeed() -> (models: [FeedImage], local: [LocalFeedImage]) {
    let models = [uniqueImage(), uniqueImage()]
    let local = models.map { LocalFeedImage(id: $0.id, description: $0.description, location: $0.location, url: $0.imageURL)}
    return (models, local)
}

extension Date {
    func adding(days: Int) -> Date {
        return Calendar(identifier: .gregorian).date(byAdding: .day, value: days, to: self)!
    }
    
    func adding(seconds: TimeInterval) -> Date  {
        return self + seconds
    }
}
