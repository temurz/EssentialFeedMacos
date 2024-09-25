//
//  ImageCommentsCellController.swift
//  EssentialFeediOS
//
//  Created by Temur on 25/09/2024.
//

import UIKit
import EssentialFeedMacos
public class ImageCommentsCellController: CellController {
    private let model: ImageCommentViewModel
    public init(model: ImageCommentViewModel) {
        self.model = model
    }
    
    public func view(in tableView: UITableView) -> UITableViewCell {
        let cell: ImageCommentCell = tableView.dequeueReusableCell()
        cell.messageLabel.text = model.message
        cell.usernameLabel.text = model.username
        cell.dateLabel.text = model.date
        return cell
    }
}
