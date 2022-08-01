//
//  Item.swift
//  CleanCrypto
//
//  Created by David Ruvinskiy on 7/28/22.
//

import Foundation

// MARK: - ItemResponse
struct ItemResponse: Codable {
    let coins: [Coin]
}

// MARK: - Coin
struct Coin: Codable {
    var item: Item
}

// MARK: - Item
class Item: Codable {
    let id: String
    let coinID: Int
    let name, symbol: String
    let marketCapRank: Int
    let large: String
    let slug: String
    let priceBtc: Double
    var priceUsd = 0.0
    let score: Int
    var description = ""

    enum CodingKeys: String, CodingKey {
        case id
        case coinID = "coin_id"
        case name, symbol
        case marketCapRank = "market_cap_rank"
        case large, slug
        case priceBtc = "price_btc"
        case score
    }
}
