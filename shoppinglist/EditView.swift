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
        VStack {
            Text("Edit item.")
                .padding(10)
            TextField("Name", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(10)
            TextField("Memo", text: $memo)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(10)
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
                                completed: false
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
                    Image(systemName: "checkmark.square")
                    Text("EDIT")
                }
            }.padding(10)
            Spacer()
        }
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
