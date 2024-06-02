//
//  Reciepts.swift
//  Economate
//
//  Created by Sualp Danacı on 2.06.2024.
//

import Foundation

struct BillHistory: Decodable, Hashable {
    var totalBills: [Bill]
}

struct Bill: Decodable, Hashable {
    var products: [Product]
}

struct Product: Decodable, Identifiable, Hashable {
    var id = UUID()
    var productName: String
    var amount: String
    var isLoss: String
    
    enum CodingKeys: String, CodingKey {
        case productName = "Product Name"
        case amount = "Amount"
        case isLoss = "IsLoss"
    }
}



