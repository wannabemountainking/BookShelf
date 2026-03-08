//
//  CreateBookView.swift
//  BookShelf
//
//  Created by YoonieMac on 3/7/26.
//

import SwiftUI

struct CreateBookView: View {
    
    @ObservedObject var vm: BookViewModel
    @Environment(\.dismiss) var dismiss
    @State var pageCountText: String
    @State var showAlert: Bool = false
    
    init(provider: BookProvider, book: Book) {
        _vm = ObservedObject(wrappedValue: .init(provider: provider, book: book))
        _pageCountText = State(wrappedValue: book.totalPagesRead != 0 ? String(book.totalPagesRead) : "")
    }
    
    
    var body: some View {
        ZStack {
            List {
                Section {
                    //Content
                    TextField("Title*", text: $vm.selectedBook.title)
                        .keyboardType(.namePhonePad)
                    TextField("Author*", text: $vm.selectedBook.author)
                        .keyboardType(.namePhonePad)
                    TextField("Total Pages", text: $pageCountText)
                        .keyboardType(.namePhonePad)
                    Toggle("Want to Read", isOn: $vm.selectedBook.isWantToRead)
                } header: {
                    Text("GENERAL")
                        .font(.title2)
                } footer: {
                    Text(" * You Should fill in title & author of the Book")
                }
                
                Section("MEMO") {
                    TextField("You are saying ... ", text: $vm.selectedBook.memo, axis: .vertical)
                        .keyboardType(.namePhonePad)
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
                }
                .disabled(!vm.selectedBook.isValid)
            }
        }
        .alert(
            "페이지 입력 오류",
            isPresented: $showAlert) {
                Button("확인") { }
            } message: {
                Text("총 페이지수 입력을 잘못했습니다. 다시 입력해 주세요")
            }
    }
}

extension CreateBookView {
    func validate() {
        guard vm.selectedBook.isValid else {
            print("Error on Validation")
            return
        }
        if let totalPages = Int(pageCountText) {
            vm.selectedBook.totalPagesRead = totalPages
        } else if pageCountText == "" {
            vm.selectedBook.totalPagesRead = 0
        } else {
            showAlert = true
            return
        }
        do {
            try vm.viewModelSave()
            dismiss()
        } catch {
            print("Error on Saving: \(error)")
        }
    }
}


//#Preview {
//    CreateBookView()
//}
