//
//  CreateBookView.swift
//  BookShelf
//
//  Created by YoonieMac on 3/7/26.
//

import SwiftUI

struct CreateBookView: View {
    
    @EnvironmentObject var vm: BookViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            List {
                Section("GENERAL") {
                    TextField("Title*", text: $vm.selectedBook.title)
                    TextField("Author*", text: $vm.selectedBook.author)
                    Toggle("Want to Read", isOn: $vm.selectedBook.isWantToRead)
                }
            }
        }
        .navigationTitle(vm.isNew ? "Fill in Book Info" : "Edit Book")
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button("Cancel") {
                    //action
                    dismiss()
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button("Done") {
                    validate()
                    dismiss()
                }
            }
        }
    }
}

extension CreateBookView {
    func validate() {
        if vm.selectedBook.isValid {
            do {
                try vm.viewModelSave()
            } catch {
                print("Error on Saving: \(error)")
            }
        } else {
            print("Error on Validation")
        }
    }
}

//#Preview {
//    CreateBookView()
//}
