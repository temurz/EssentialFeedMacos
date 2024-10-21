//
//  UIImageView+Extension.swift
//  EssentialFeediOS
//
//  Created by Temur on 21/10/2024.
//

import UIKit
extension UIImageView {
    func setImageAnimated(_ newImage: UIImage?) {
        image = newImage
        
        guard newImage != nil else { return }
        
        alpha = 0
        UIView.animate(withDuration: 0.25) {
            self.alpha = 1
        }
    }
}
