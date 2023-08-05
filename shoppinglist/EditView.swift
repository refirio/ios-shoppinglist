//
//  EditView.swift
//  shoppinglist
//
//  Created by refirio.
//

import SwiftUI

struct EditView: View {
    @Environment(\.presentationMode) var presentation
    @State var id: UUID
    @State private var name = ""
    @State private var memo = ""
    @State private var completed = false
    
    var userDefaults = UserDefaults.standard

    var body: some View {
        Form {
            VStack {
                TextField("Name", text: $name)
            }
            ZStack {
                if memo.isEmpty {
                    VStack {
                        HStack {
                            Text("Memo")
                                .padding(EdgeInsets(
                                    top: 16,
                                    leading: 0,
                                    bottom: 0,
                                    trailing: 0
                                ))
                                .opacity(0.25)
                            Spacer()
                        }
                        Spacer()
                    }
                }
                TextEditor(text: $memo)
                    .padding(EdgeInsets(
                        top: 0,
                        leading: -4,
                        bottom: 0,
                        trailing: 0
                    ))
                    .frame(height: 200)
            }
            VStack {
                Toggle("Completed", isOn: $completed)
            }
            Button(action: {
                let temps = loadProducts()
                
                var products: [Product] = []
                for temp in temps {
                    if temp.id == id {
                        products.append(
                            Product(
                                id: id,
                                name: name,
                                memo: memo,
                                completed: completed
                            )
                        )
                    } else {
                        products.append(temp)
                    }
                }
                
                saveProducts(data: products)

                self.presentation.wrappedValue.dismiss()
            }) {
                HStack {
                    Spacer()
                    Image(systemName: "checkmark.square")
                    Text("EDIT")
                    Spacer()
                }
            }
        }
        .navigationTitle("EDIT")
        .navigationBarTitle("", displayMode: .inline)
        .onAppear {
            let products = loadProducts()
            
            for product in products {
                if product.id == id {
                    name = product.name
                    memo = product.memo
                    completed = product.completed

                    break
                }
            }
        }
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(id: UUID())
    }
}
