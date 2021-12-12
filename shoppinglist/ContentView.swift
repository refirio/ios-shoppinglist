//
//  ContentView.swift
//  shoppinglist
//
//  Created by refirio.
//

import SwiftUI

struct ContentView: View {
    @State private var products: [Product] = []

    var body: some View {
        NavigationView {
            List {
                ForEach(products) { product in
                    NavigationLink(destination: EditView(id: product.id).onDisappear(perform: {
                        products = loadProducts()
                    })) {
                        Text(product.name)
                    }
                }
                .onMove(perform: move)
                .onDelete(perform: delete)
            }
            .navigationBarTitle("商品", displayMode: .inline)
            .navigationBarItems(trailing:
                HStack {
                    NavigationLink(destination: AddView().onDisappear(perform: {
                        products = loadProducts()
                    })) {
                        Text("追加")
                    }
                    MyEditButton()
                }
            )
        }
        .onAppear {
            products = loadProducts()
        }
    }
    
    func move(from source: IndexSet, to destination: Int) {
        products.move(fromOffsets: source, toOffset: destination)

        saveProducts(data: products)
    }

    func delete(at offsets: IndexSet) {
        products.remove(atOffsets: offsets)

        saveProducts(data: products)
    }
}

struct MyEditButton: View {
    @Environment(\.editMode) var editMode
    
    var body: some View {
        Button(action: {
            withAnimation() {
                if editMode?.wrappedValue.isEditing == true {
                    editMode?.wrappedValue = .inactive
                } else {
                    editMode?.wrappedValue = .active
                }
            }
        }) {
            if editMode?.wrappedValue.isEditing == true {
                Text("完了")
            } else {
                Text("編集")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
