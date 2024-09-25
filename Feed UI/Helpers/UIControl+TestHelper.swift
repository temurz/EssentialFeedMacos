//
//  UIControl+TestHelper.swift
//  EssentialFeediOSTests
//
//  Created by Temur on 08/04/2024.
//

import UIKit
extension UIRefreshControl {
    func simulatePullToRefresh() {
        allTargets.forEach({ target in
            actions(forTarget: target, forControlEvent: .valueChanged)?.forEach {
                (target as NSObject).perform(Selector($0))
            }
        })
    }
}
