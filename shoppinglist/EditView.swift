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
                    Image(systemName: "checkmark.square")
                    Text("EDIT")
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
