//
//  MainView.swift
//  BookShelf
//
//  Created by yoonie on 3/7/26.
//

import SwiftUI

struct MainView: View {
    
    @FetchRequest(fetchRequest: Book.all()) var books: FetchedResults<Book>
    @EnvironmentObject var vm: BookViewModel
    @Environment(\.dismiss) var dismiss
    let provider = BookProvider.shared
    
    @State var bookToEdit: Book?
    @State var isWantToReadOn: Bool = false
    
    @State var isFiltered: BookConfig.Filter = .all
    @State var sort: BookConfig.Sort = .asc
    @State var isAsc: Bool = false
    
    var body: some View {
        
        NavigationStack {
            //sidebar
            ZStack {
                if books.isEmpty {
                    NoBookView()
                } else {
                    List {
                        ForEach(books) { book in
                            NavigationLink {
                                // destination
                                BookDetailView(book: book)
                            } label: {
                                BookRowView(provider: provider, book: book)
                                    .swipeActions(edge: .leading, allowsFullSwipe: false) {
                                        Button {
                                            //TODO: Delete Action
                                            do {
                                                try provider.delete(book: book, context: provider.viewContext)
                                            } catch {
                                                print("Error On Delete: \(error)")
                                            }
                                        } label: {
                                            Label("Delete", systemImage: "trash")
                                                .foregroundStyle(Color.red.opacity(0.5))
                                        }
                                    }//: swipeActions
                                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                        Button {
                                            // TODO: Edit Action
                                            bookToEdit = book
                                        } label: {
                                            Label("Edit", systemImage: "pencel")
                                                .foregroundStyle(Color.green.opacity(0.5))
                                        }
                                    }
                            } //:NavLink
                        } //:LOOP
                    } //:LIST
                }//:CONDITION
            } //:ZSTACK
            .navigationTitle("📚 BookShelf")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        // TODO: add action
                        
                    } label: {
                        Image(systemName: "plus")
                            .font(.title2)
                            .symbolVariant(.circle)
                            .foregroundStyle(Color.accentColor.opacity(0.5))
                    }
                } //: toolbarItem
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        // TODO: isWantToReadOn action
                        
                    } label: {
                        Image(systemName: isWantToReadOn ? "bookmark.fill" : "bookmark")
                            .font(.title2)
                            .foregroundStyle(isWantToReadOn ? Color.green.opacity(0.5) : Color.accentColor.opacity(0.5))
                    }
                }//toolbarItem
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        // TODO: sort action
                        
                    } label: {
                        Image(systemName: isAsc ? "arrow.down" : "arrow.up")
                            .font(.title2)
                            .symbolVariant(.circle)
                            .foregroundStyle(Color.accentColor.opacity(0.5))
                    }
                }//toolbarItem
            }// toolbar
            .sheet(item: $bookToEdit) {
                //dismiss
                dismiss()
            } content: { book in
                NavigationStack {
                    CreateBookView()
                }
            }
        } //:NAVIGATION
    }//:body
}

#Preview {
    MainView()
}
