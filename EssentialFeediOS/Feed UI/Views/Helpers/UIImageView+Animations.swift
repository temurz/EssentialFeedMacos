//
//  UIImageView+Animations.swift
//  EssentialFeediOS
//
//  Created by Temur on 08/02/2024.
//

import UIKit
extension UIImageView {
    func setAnimatedImage(_ newImage: UIImage?) {
        image = newImage
        
        guard newImage != nil else { return }
        
        alpha = 0
        UIView.animate(withDuration: 0.25) {
            self.alpha = 1
        }
    }
}

