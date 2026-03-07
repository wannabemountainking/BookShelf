//
//  BookDetailView.swift
//  BookShelf
//
//  Created by YoonieMac on 3/7/26.
//

import SwiftUI

struct BookDetailView: View {
    
    @Environment(\.dismiss) var dismiss
    let book: Book
    
    var body: some View {
        NavigationStack {
            List {
                Section("BOOK DETAILS") {
                    //content
                    LabeledContent("TITLE", value: book.title)
                    LabeledContent("AUTHOR", value: book.author)
                    LabeledContent("isWantToRead", value: book.isWantToRead ? "yes" : "no")
                    LabeledContent("totalPagesRead", value:
                                    "\(book.totalPagesRead) page")
                }
                
                Section("MEMO") {
                    Text(book.memo)
                }
            }
            .navigationTitle("Book Information")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        //action
                        dismiss()
                    } label: {
                        Image(systemName: "arrow.backward.circle")
                    }
                }
            }
        }
    }
}

//#Preview {
//    BookDetailView()
//}
