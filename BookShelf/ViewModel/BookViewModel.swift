//
//  BookViewModel.swift
//  BookShelf
//
//  Created by YoonieMac on 3/7/26.
//

import Foundation
import CoreData
import Combine


final class BookViewModel: ObservableObject {
    
    let provider: BookProvider
    var context: NSManagedObjectContext
    
    @Published var selectedBook: Book?
    @Published var isNew: Bool = false
    
    init(provider: BookProvider, book: Book? = nil) {
        self.provider = provider
        
        if let book, let existingBook = provider.exist(context: provider.viewContext, book: book) {
            self.selectedBook = existingBook
            self.context = provider.viewContext
            self.isNew = false
        } else {
            self.context = provider.newContext
            self.selectedBook = Book.empty(context: self.context)
            self.isNew = true
        }
    }
    
    func viewModelSave() {
        if self.context.hasChanges {
            do {
                try context.save()
                objectWillChange.send()
            } catch {
                print("Error Saving: \(error)")
            }
        }
    }
}
