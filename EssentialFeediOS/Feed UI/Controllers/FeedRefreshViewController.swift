//
//  FeedRefreshViewController.swift
//  EssentialFeediOS
//
//  Created by Temur on 31/01/2024.
//

import UIKit
protocol FeedRefreshViewControllerDelegate {
    func didRequestFeedRefresh()
}
final public class FeedRefreshViewController: NSObject, FeedLoadingView {
    @IBOutlet public var view: UIRefreshControl?

    var delegate: FeedRefreshViewControllerDelegate?

    @IBAction func refresh() {
        delegate?.didRequestFeedRefresh()
    }
    
    func display(_ viewModel: FeedLoadingViewModel) {
        if viewModel.isLoading {
            self.view?.beginRefreshing()
        }else {
            self.view?.endRefreshing()
        }
    }
}
