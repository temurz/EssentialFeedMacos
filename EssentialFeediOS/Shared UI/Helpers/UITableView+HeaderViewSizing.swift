//
//  UITableView+HeaderViewSizing.swift
//  EssentialFeediOS
//
//  Created by Temur on 10/05/2024.
//

import UIKit
extension UITableView {
    func sizeTableHeaderToFit() {
        guard let header = tableHeaderView else { return }

        let size = header.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)

        let needsFrameUpdate = header.frame.height != size.height
        if needsFrameUpdate {
            header.frame.size.height = size.height
            tableHeaderView = header
        }
    }
}
