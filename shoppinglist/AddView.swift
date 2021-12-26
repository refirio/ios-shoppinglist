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
        VStack {
            Text("Add item.")
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
                HStack {
                    Image(systemName: "checkmark.square")
                    Text("ADD")
                }
            }.padding(10)
            Spacer()
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView()
    }
}
