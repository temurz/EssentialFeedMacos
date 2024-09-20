//
//  RemoteImageCommentsLoader.swift
//  EssentialFeedMacos
//
//  Created by Temur on 20/08/2024.
//

import Foundation
public typealias RemoteImageCommentsLoader = RemoteLoader<[ImageComment]>

public extension RemoteImageCommentsLoader {
    convenience init(url: URL, client: HTTPClient) {
        self.init(url: url, client: client, mapper: ImageCommentsMapper.map)
    }
}
