//
//  FeedRefreshViewController.swift
//  EssentialFeediOS
//
//  Created by Temur on 31/01/2024.
//

import UIKit
final public class FeedRefreshViewController: NSObject, FeedLoadingView {
    public lazy var view = loadView()

    private let presenter: FeedPresenter
    
    init(presenter: FeedPresenter) {
        self.presenter = presenter
    }

    @objc func refresh() {
        presenter.loadFeed()
    }
    
    func display(isLoading: Bool) {
        if isLoading {
            self.view.beginRefreshing()
        }else {
            self.view.endRefreshing()
        }
    }
    
    private func loadView() -> UIRefreshControl {
        let view = UIRefreshControl()
        view.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return view
    }
}
