//
//  FeedPresenterTests.swift
//  EssentialFeedMacosTests
//
//  Created by Temur on 09/02/2024.
//

import XCTest

final class FeedPresenter {
    
    init(view: Any) {
        
    }
    
}

class FeedPresenterTests: XCTestCase {
    func test_init_doesNotSendAnyMessagesToView() {
        let (_, view) = makeSUT()
        
        XCTAssertTrue(view.messages.isEmpty, "Expected no view messages")
    }
    
    
    
    
    private func makeSUT() -> (FeedPresenter, ViewSpy) {
        let view = ViewSpy()
        let presenter = FeedPresenter(view: view)
        trackForMemoryLeaks(view)
        trackForMemoryLeaks(presenter)
        
        return (presenter, view)
    }
    
    private class ViewSpy {
        var messages = [Any]()
        
    }
}
