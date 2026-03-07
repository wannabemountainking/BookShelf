//
//  BookRowView.swift
//  BookShelf
//
//  Created by YoonieMac on 3/7/26.
//

import SwiftUI
import CoreData

struct BookRowView: View {
    
    let provider: BookProvider
    @ObservedObject var book: Book
    
    var body: some View {
        HStack {
            VStack {
                Text(book.title)
                    .font(.title2)
                    .fontWeight(.ultraLight)
                Text(book.author)
                    .font(.caption)
                    .fontWeight(.bold)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .overlay(alignment: .topTrailing) {
            Button {
                //TODO: isWantToRead Action
                book.isWantToRead.toggle()
                save()
            } label: {
                Image(systemName: book.isWantToRead ? "bookmark.fill" : "bookmark")
                    .font(.title2)
                    .foregroundStyle(book.isWantToRead ? Color.green.opacity(0.5) : Color.gray.opacity(0.5))
            }
            .buttonStyle(.plain)
        }
    }
    
    func save() {
        do {
            try provider.viewContext.save()
        } catch {
            print("Error Saving: \(error)")
        }
    }
}

//#Preview {
//    BookRowView()
//}
