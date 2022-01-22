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
            VStack {
                Text("Name")
                    .frame(maxWidth: .infinity, alignment: .leading)
                TextField("", text: $name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }.padding(10)
            VStack {
                Text("Memo")
                    .frame(maxWidth: .infinity, alignment: .leading)
                TextEditor(text: $memo)
                    .frame(width: UIScreen.main.bounds.width * 0.95, height: 100)
                    .overlay(
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(Color(red: 0.9, green: 0.9, blue: 0.9), lineWidth: 1)
                    )
            }.padding(10)
            Toggle("Completed", isOn: $completed)
                .padding(10)
            Button(action: {
                let temps = loadProducts()
                
                var products: [Product] = []
                products.append(
                    Product(
                        name: name,
                        memo: memo,
                        completed: completed
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
        .padding(EdgeInsets(
            top: 15,
            leading: 0,
            bottom: 0,
            trailing: 0
        ))
        .navigationBarTitle("", displayMode: .inline)
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView()
    }
}
