//
//  UITableView+Extension.swift
//  EssentialFeediOS
//
//  Created by Temur on 21/10/2024.
//

import UIKit
extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>() -> T {
        let identifier = String(describing: T.self)
        return dequeueReusableCell(withIdentifier: identifier) as! T
    }
}
