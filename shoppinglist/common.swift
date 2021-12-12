//
//  common.swift
//  shoppinglist
//
//  Created by refirio.
//

import Foundation

struct Product: Identifiable, Codable {
    var id = UUID()
    var name: String
    var memo: String
    var completed: Bool
}

func loadProducts() -> [Product] {
    var products: [Product] = []

    if let data = UserDefaults.standard.value(forKey: "products") as? Data {
        products = try! PropertyListDecoder().decode(Array<Product>.self, from: data)
    } else {
        products = []
    }

    return products
}

func saveProducts(data articles: [Product]) -> Void {
    UserDefaults.standard.set(try? PropertyListEncoder().encode(articles), forKey: "products")
}
