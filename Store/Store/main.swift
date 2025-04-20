//
//  main.swift
//  Store
//
//  Created by Ted Neward on 2/29/24.
//

import Foundation

protocol SKU {
    var name: String { get }
    func price() -> Int
}

class Item: SKU {
    let name: String
    private let priceEach: Int
    
    init(name: String, priceEach: Int) {
        self.name = name
        self.priceEach = priceEach
    }
    
    func price() -> Int {
        return priceEach
    }
}

class Coupon: SKU {
    let name: String
    private let originalPrice: Int
    private let discountPercent = 15

    init(name: String, priceEach: Int) {
        self.name = "\(name) (15% off)"
        self.originalPrice = priceEach
    }

    func price() -> Int {
        let discount = (originalPrice * discountPercent + 50) / 100
        return originalPrice - discount
    }
}

class Receipt {
    private var skus: [SKU] = []

    func add(_ sku: SKU) {
        skus.append(sku)
    }

    func items() -> [SKU] {
        return skus
    }

    func total() -> Int {
        return skus.reduce(0) { $0 + $1.price() }
    }

    func output() -> String {
        var result = "Receipt:\n"
        
        for sku in skus {
            let dollars = sku.price() / 100
            let cents = sku.price() % 100
            let price = String(format: "$%d.%02d", dollars, cents)
            result += "\(sku.name): \(price)\n"
        }
        
        result += "------------------\n"
        
        let totalDollars = total() / 100
        let totalCents = total() % 100
        let totalPrice = String(format: "$%d.%02d", totalDollars, totalCents)
        result += "TOTAL: \(totalPrice)"
        
        return result
    }
}

class Register {
    private var receipt: Receipt
    
    init() {
        receipt = Receipt()
    }

    func scan(_ sku: SKU) {
        receipt.add(sku)
    }

    func subtotal() -> Int {
        return receipt.total()
    }

    func total() -> Receipt {
        let completedReceipt = receipt
        receipt = Receipt()
        return completedReceipt
    }
}

class Store {
    let version = "0.1"
    func helloWorld() -> String {
        return "Hello world"
    }
}
