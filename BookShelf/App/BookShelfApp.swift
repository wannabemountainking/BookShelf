//
//  BookShelfApp.swift
//  BookShelf
//
//  Created by yoonie on 3/7/26.
//

import SwiftUI

@main
struct BookShelfApp: App {
    
    @StateObject var vm: BookViewModel = BookViewModel(provider: BookProvider.shared)
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(vm)
        }
    }
}
