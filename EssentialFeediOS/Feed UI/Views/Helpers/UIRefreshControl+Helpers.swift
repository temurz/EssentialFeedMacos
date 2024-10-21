//
//  UIRefreshControl+Helpers.swift
//  EssentialFeediOS
//
//  Created by Temur on 21/10/2024.
//

import UIKit

extension UIRefreshControl {
    func update(isRefreshing: Bool) {
        isRefreshing ? beginRefreshing() : endRefreshing()
    }
}
