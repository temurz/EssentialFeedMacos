//
//  UITableView+Extension.swift
//  EssentialFeediOS
//
//  Created by Temur on 08/02/2024.
//

import UIKit
extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>() -> T {
        let identifier = String(describing: T.self)
        return self.dequeueReusableCell(withIdentifier: identifier) as! T
    }
}
