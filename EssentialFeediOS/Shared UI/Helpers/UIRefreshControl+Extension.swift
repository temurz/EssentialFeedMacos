//
//  UIRefreshControl+Extension.swift
//  EssentialFeediOS
//
//  Created by Temur on 25/09/2024.
//

import Foundation
import UIKit
extension UIRefreshControl {
    func update(isRefreshing: Bool) {
        isRefreshing ? beginRefreshing() : endRefreshing()
    }
}
