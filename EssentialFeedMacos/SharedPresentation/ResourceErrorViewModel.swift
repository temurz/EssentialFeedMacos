//
//  ResourceErrorViewModel.swift
//  EssentialFeedMacos
//
//  Created by Temur on 23/09/2024.
//

import Foundation
public struct ResourceErrorViewModel {
    public let message: String?
    
    static var noError: ResourceErrorViewModel {
        return ResourceErrorViewModel(message: nil)
    }
    
    public static func error(message: String) -> ResourceErrorViewModel {
        return ResourceErrorViewModel(message: message)
    }
}
