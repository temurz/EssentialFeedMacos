//
//  CoreDataFeedStore.swift
//  EssentialFeedMacos
//
//  Created by Temur on 27/11/2023.
//

import Foundation
import CoreData

public class CoreDataFeedStore {
    private static let modelName = "FeedStore"
    private static let model = NSManagedObjectModel.with(name: modelName, in: Bundle(for: CoreDataFeedStore.self))
    
    private let container: NSPersistentContainer
    private let context: NSManagedObjectContext
    
    enum StoreError: Error {
        case modelNotFound
        case failedToLoadPersistentContainer(Error)
    }

    
    public init(storeURL: URL) throws {
        let bundle = Bundle(for: CoreDataFeedStore.self)
//        container = try NSPersistentContainer.load(modelName: "FeedStore", url: storeURL, in: bundle)
//        context = container.newBackgroundContext()
        guard CoreDataFeedStore.model != nil else {
            throw StoreError.modelNotFound
        }
        
        do {
            container = try NSPersistentContainer.load(modelName: CoreDataFeedStore.modelName, url: storeURL, in: bundle)
            context = container.newBackgroundContext()
        } catch {
            throw StoreError.failedToLoadPersistentContainer(error)
        }
    }
    
    func perform(_ action: @escaping (NSManagedObjectContext) -> Void) {
        let context = self.context
        context.perform { action(context) }
    }
    
    private func cleanUpReferencesToPersistentStores() {
        context.performAndWait {
            let coordinator = self.container.persistentStoreCoordinator
            try? coordinator.persistentStores.forEach(coordinator.remove)
        }
    }
    
    deinit {
        cleanUpReferencesToPersistentStores()
    }
}


