//
//  UIButton+TestHelper.swift
//  EssentialFeediOSTests
//
//  Created by Temur on 08/04/2024.
//

import UIKit
extension UIButton {
    func simulateTap() {
            allTargets.forEach { target in
                actions(forTarget: target, forControlEvent: .touchUpInside)?.forEach {
                    (target as NSObject).perform(Selector($0))
                }
            }
        }
}
