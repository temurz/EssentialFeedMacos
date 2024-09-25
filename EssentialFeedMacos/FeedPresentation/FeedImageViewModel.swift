//
//  FeedImageViewModel.swift
//  EssentialFeedMacos
//
//  Created by Temur on 25/09/2024.
//

import Foundation
public struct FeedImageViewModel {
    public let description: String?
    public let location: String?
    
    public var hasLocation: Bool {
        return location != nil
    }
}
