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
                    Spacer()
                    Image(systemName: "checkmark.square")
                    Text("ADD")
                    Spacer()
                }
            }
        }
        .navigationTitle("ADD")
        .navigationBarTitle("", displayMode: .inline)
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView()
    }
}
