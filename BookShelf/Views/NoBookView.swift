//
//  NoBookView.swift
//  BookShelf
//
//  Created by YoonieMac on 3/7/26.
//

import SwiftUI

struct NoBookView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("😰 No Books")
                .font(.largeTitle.bold())
            Text("☝️위에 + 버튼을 눌러서 새로운 책를 추가하세요")
                .font(.callout)
        }
    }
}

#Preview {
    NoBookView()
}
