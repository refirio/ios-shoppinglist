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
            Text("商品を編集します。")
                .padding(10)
            TextField("商品名", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(10)
            TextField("メモ", text: $memo)
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
                Text("編集")
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
