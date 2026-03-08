//
//  Book.swift
//  BookShelf
//
//  Created by yoonie on 3/7/26.
//

import Foundation
import CoreData


final class Book: NSManagedObject, Identifiable {
    @NSManaged var title: String
    @NSManaged var author: String
    @NSManaged var isWantToRead: Bool
    @NSManaged var memo: String
    @NSManaged var totalPagesRead: Int
    
    var isValid: Bool {
        !title.isEmpty && !author.isEmpty
    }
}

extension Book {
    static func all() -> NSFetchRequest<Book> {
        let request = NSFetchRequest<Book>(entityName: "Book")
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Book.title, ascending: true)]
        return request
    }
    
    static func empty(context: NSManagedObjectContext) -> Book {
        Book(context: context)
    }
    
    // 필터 조건
    static func filtering(config: BookConfig) -> NSPredicate {
        switch config.filter {
        case .all:
            return NSPredicate(value: true)
        case .wantToRead:
            return NSPredicate(format: "isWantToRead == %@", NSNumber(value: true))
        }
    }
    
    // 정렬 조건
    static func sort(config: BookConfig) -> [NSSortDescriptor] {
        [NSSortDescriptor(keyPath: \Book.title, ascending: config.sort == .asc)]
    }
}


// MARK: - Configuration Pattern

struct BookConfig: Equatable {
    enum Filter {
        case all, wantToRead
    }
    enum Sort {
        case asc, dec
    }
    // 필터 설정
    var filter: Filter = .all
    // 정렬 설정
    var sort: Sort = .asc
}

