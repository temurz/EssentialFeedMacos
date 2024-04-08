//
//  LoaderSpy+TestHelper.swift
//  EssentialFeediOSTests
//
//  Created by Temur on 08/04/2024.
//

import EssentialFeediOS
import EssentialFeedMacos
class LoaderSpy: FeedLoader, FeedImageDataLoader {
    //FeedLoader
    var loadFeedCallCount: Int {
        return feedRequests.count
    }
    
    private var feedRequests = [(FeedLoader.Result) -> ()]()
    
    func load(completion: @escaping (FeedLoader.Result) -> Void) {
        feedRequests.append(completion)
    }
    
    func completeFeedLoading(with feed: [FeedImage] = [], at index: Int = 0) {
        feedRequests[index](.success(feed))
    }
    
    func completeFeedLoadingWithError(at index: Int) {
        let error = NSError(domain: "an error", code: 0)
        feedRequests[index](.failure(error))
    }
    
    private struct TaskSpy: FeedImageDataLoaderTask {
        let cancelCallback: () -> Void
        func cancel() {
            cancelCallback()
        }
    }
    //FeedImageDataLoader
    private var imageRequests = [(url: URL, completion: (FeedImageDataLoader.Result) -> Void)]()
    var loadedImageURLs: [URL] {
        return imageRequests.map {$0.url}
    }
    private(set) var cancelledImageURLs: [URL] = []
      
    func loadImageData(from url: URL, completion: @escaping (Result<Data,Error>) -> Void) -> FeedImageDataLoaderTask {
        imageRequests.append((url, completion))
        return TaskSpy { [weak self] in self?.cancelledImageURLs.append(url)}
    }
    
    func completeImageLoading(with imageData: Data = Data(), at index: Int = 0) {
        imageRequests[index].completion(.success(imageData))
    }
    
    func completeImageLoadingWithError(at index: Int = 0) {
        let error = NSError(domain: "any error", code: 0)
        imageRequests[index].completion(.failure(error))
    }
}
