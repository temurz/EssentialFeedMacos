//
//  FeedRefreshViewController.swift
//  EssentialFeediOS
//
//  Created by Temur on 31/01/2024.
//

import UIKit
final public class FeedRefreshViewController: NSObject {
    public lazy var view: UIRefreshControl = {
        let view = UIRefreshControl()
        binded(view)
        return view
    }()

    private let viewModel: FeedViewModel
    
    init(viewModel: FeedViewModel) {
        self.viewModel = viewModel
    }

    @objc func refresh() {
        viewModel.loadFeed()
    }
    
    private func binded(_ view: UIRefreshControl) {
        viewModel.onChange = { [weak self] viewModel in
            if viewModel.isLoading {
                self?.view.beginRefreshing()
            }else {
                self?.view.endRefreshing()
            }
        }
        view.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }
}
