//
//  FeedPresenterTests.swift
//  EssentialFeedMacosTests
//
//  Created by Temur on 09/02/2024.
//

import XCTest

struct FeedErrorViewModel {
    let message: String?
    
    static var noError: FeedErrorViewModel {
        return FeedErrorViewModel(message: nil)
    }
}

protocol FeedErrorView {
    func display(_ viewModel: FeedErrorViewModel)
}

struct FeedLoadingViewModel {
    let isLoading: Bool
}

protocol FeedLoadingView {
    func display(_ viewModel: FeedLoadingViewModel)
}

final class FeedPresenter {
    private let loadingView: FeedLoadingView
    private let errorView: FeedErrorView
    
    init(errorView: FeedErrorView, loadingView: FeedLoadingView) {
        self.errorView = errorView
        self.loadingView = loadingView
    }
    
    func didStartLoadingFeed() {
        errorView.display(.noError)
        loadingView.display(FeedLoadingViewModel(isLoading: true))

    }
}

class FeedPresenterTests: XCTestCase {
    func test_init_doesNotSendAnyMessagesToView() {
        let (_, view) = makeSUT()
        
        XCTAssertTrue(view.messages.isEmpty, "Expected no view messages")
    }
    
    func test_didStartLoadingFeed_displayNoErrorMessageAndStartLoading() {
        let (sut, view) = makeSUT()
        
        sut.didStartLoadingFeed()
        
        
        
        XCTAssertEqual(view.messages, [
            .display(errorMessage: .none),
            .display(isLoading: true)
        ])
    }
    
    //MARK: - Helpers
    private func makeSUT() -> (FeedPresenter, ViewSpy) {
        let view = ViewSpy()
        let presenter = FeedPresenter(errorView: view, loadingView: view)
        trackForMemoryLeaks(view)
        trackForMemoryLeaks(presenter)
        
        return (presenter, view)
    }
    
    private class ViewSpy: FeedErrorView, FeedLoadingView {
        enum Message: Equatable {
            case display(errorMessage: String?)
            case display(isLoading: Bool)
        }
        private(set) var messages = [Message]()
        
        func display(_ viewModel: FeedErrorViewModel) {
            messages.append(.display(errorMessage: viewModel.message))
        }
        
        func display(_ viewModel: FeedLoadingViewModel) {
            messages.append(.display(isLoading: viewModel.isLoading))
        }
    }
}
