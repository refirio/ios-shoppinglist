//
//  AddView.swift
//  shoppinglist
//
//  Created by refirio.
//

import SwiftUI

struct AddView: View {
    @Environment(\.presentationMode) var presentation
    @State private var name = ""
    @State private var memo = ""
    @State private var completed = false

    var body: some View {
        Text("商品を追加します。")
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
            products.append(
                Product(
                    name: name,
                    memo: memo,
                    completed: false
                )
            )
            for temp in temps {
                products.append(temp)
            }
            
            saveProducts(data: products)

            self.presentation.wrappedValue.dismiss()
        }) {
            Text("追加")
        }.padding(10)
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView()
    }
}
