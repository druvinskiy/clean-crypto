//
//  Detail.swift
//  CleanCrypto
//
//  Created by David Ruvinskiy on 7/29/22.
//

import Foundation

// MARK: - Detail
struct Detail: Codable {
    let marketData: MarketData
    let description: [String: String]
    
    enum CodingKeys: String, CodingKey {
        case marketData = "market_data"
        case description = "description"
    }
}

// MARK: - MarketData
struct MarketData: Codable {
    let currentPrice: [String: Double]
    
    enum CodingKeys: String, CodingKey {
        case currentPrice = "current_price"
    }
}
