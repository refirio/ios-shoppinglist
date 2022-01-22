//
//  ContentView.swift
//  shoppinglist
//
//  Created by refirio.
//

import SwiftUI

struct ContentView: View {
    @State private var products: [Product] = []
    @State private var query = ""
    
    private var filtered: [Product] {
        guard !query.isEmpty else {
            return products
        }
        return products.filter {
            $0.name.localizedCaseInsensitiveContains(query)
        }
    }

    var body: some View {
        NavigationView {
            List {
                ForEach(filtered) { product in
                    NavigationLink(destination: EditView(id: product.id).onDisappear(perform: {
                        products = loadProducts()
                    })) {
                        HStack {
                            if (product.completed) {
                                Image(systemName: "checkmark.square")
                            } else {
                                Image(systemName: "square")
                            }
                            Text(product.name)
                        }
                    }
                }
                .onMove(perform: move)
                .onDelete(perform: delete)
            }
            .searchable(text: $query)
            .navigationBarTitle("Shopping List")
            .navigationBarItems(trailing:
                HStack {
                    NavigationLink(destination: AddView().onDisappear(perform: {
                        products = loadProducts()
                    })) {
                        Image(systemName: "bag.badge.plus")
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
                Image(systemName: "checkmark.square")
            } else {
                Image(systemName: "list.bullet")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
