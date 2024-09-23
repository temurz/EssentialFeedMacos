//
//  LoadResourcePresenterTests.swift
//  EssentialFeedMacosTests
//
//  Created by Temur on 23/09/2024.
//

import XCTest
import EssentialFeedMacos
final class LoadResourcePresenterTests: XCTestCase {
    
    func test_title_isLocalized() {
        XCTAssertEqual(LoadResourcePresenter.title, localized("FEED_VIEW_TITLE"))
    }
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
    
    func test_didFinishLoadingFeed_displayFeedAndStopLoadingOnSuccess() {
        let (sut, view) = makeSUT()
        
        let image = makeImage()
        sut.didFinishLoadingFeed(with: [image])
        
        XCTAssertEqual(view.messages, [
            .display(feed: [image]),
            .display(isLoading: false)
        ])
    }
    
    func test_didFinishLoadingFeed_displayErrorOnFinishingWithError() {
        let (sut, view) = makeSUT()
        
        sut.didFinishLoadingFeed(with: anyNSError())
        
        XCTAssertEqual(view.messages, [
            .display(isLoading: false),
            .display(errorMessage: localized("FEED_VIEW_CONNECTION_ERROR"))
        ])
    }
    
    //MARK: - Helpers
    private func makeSUT() -> (LoadResourcePresenter, ViewSpy) {
        let view = ViewSpy()
        let presenter = LoadResourcePresenter(errorView: view, loadingView: view, feedView: view)
        trackForMemoryLeaks(view)
        trackForMemoryLeaks(presenter)
        
        return (presenter, view)
    }
    
    private func makeImage(description: String? = nil, location: String? = nil, url: URL = URL(string: "http://any-url.com")!) -> FeedImage {
        return FeedImage(id: UUID(), description: description, location: location, imageURL: url)
    }
    
    func localized(_ key: String, file: StaticString = #file, line: UInt = #line) -> String {
        let table = "Feed"
        let bundle = Bundle(for: LoadResourcePresenter.self)
        let value = bundle.localizedString(forKey: key, value: nil, table: table)
        if value == key {
            XCTFail("Missing localized string for key: \(key) in table: \(table)", file: file, line: line)
        }
        return value
    }
    
    private class ViewSpy: FeedErrorView, FeedLoadingView, FeedView {
        enum Message: Hashable {
            case display(errorMessage: String?)
            case display(isLoading: Bool)
            case display(feed: [FeedImage])
        }
        private(set) var messages = Set<Message>()
        
        func display(_ viewModel: FeedErrorViewModel) {
            messages.insert(.display(errorMessage: viewModel.message))
        }
        
        func display(_ viewModel: FeedLoadingViewModel) {
            messages.insert(.display(isLoading: viewModel.isLoading))
        }
        
        func display(_ viewModel: FeedViewModel) {
            messages.insert(.display(feed: viewModel.feed))
        }
    }
}
