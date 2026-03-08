//
//  BookProvider.swift
//  BookShelf
//
//  Created by yoonie on 3/7/26.
//

import Foundation
import CoreData


final class BookProvider {
    
    static let shared: BookProvider = BookProvider()
    
    private let container: NSPersistentContainer
    var viewContext: NSManagedObjectContext {
        container.viewContext
    }
    
    var newContext: NSManagedObjectContext {
        let context = container.newBackgroundContext()
        context.persistentStoreCoordinator = container.persistentStoreCoordinator
        return context
    }
    
    private init() {
        self.container = NSPersistentContainer(name: "BookData")
        
        container.loadPersistentStores { description, error in
            if let error {
                print("ERROR LOADING CORE DATA: \(error)")
            } else {
                print("SUCCESSFULLY LOADED CORE DATA: \(description)")
                self.viewContext.automaticallyMergesChangesFromParent = true
//                print("viewContext 설정됨")
            }
        }
    }
    
    func exist(context: NSManagedObjectContext, book: Book) -> Book? {
        try? context.existingObject(with: book.objectID) as? Book
    }
    
    func delete(book: Book, context: NSManagedObjectContext) throws {
        if let existingBook = exist(context: context, book: book) {
            context.delete(existingBook)
            Task(priority: .background) {
                try await context.perform {
                    try context.save()
                }
            }
        }
    }
}

