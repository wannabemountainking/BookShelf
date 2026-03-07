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
            List {
                if books.isEmpty {
                    NoBookView()
                } else {
                    ForEach(books) { book in
                        NavigationLink {
                            // destination
                            CreateBookView()
                        } label: {
                            BookRowView()
                        } //:NavLink
                    } //:LOOP
                }//:CONDITIONAL
            } //:LIST
            .navigationTitle("📚 BookShelf")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
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
                        Text("🔖")
                            .font(.title2)
                            .symbolVariant(.circle)
                            .foregroundStyle(Color.accentColor.opacity(0.5))
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
                BookDetailView(book: book)
            }
        } //:NAVIGATION
    }//:body
}

#Preview {
    MainView()
}
