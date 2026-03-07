//
//  BookRowView.swift
//  BookShelf
//
//  Created by YoonieMac on 3/7/26.
//

import SwiftUI

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
            } label: {
                
            }

        }
    }
}

#Preview {
    BookRowView()
}
