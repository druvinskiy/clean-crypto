//
//  NetworkManager.swift
//  CleanCrypto
//
//  Created by David Ruvinskiy on 7/28/22.
//

import UIKit

class NetworkManager {
    
    static let shared = NetworkManager()
    private let baseUrl = "https://api.coingecko.com/api/v3/"
    let cache = NSCache<NSString, UIImage>()
    
    private init() {}
    
    func getTrendingCoinsWithDetails(completed: @escaping (Result<[Coin], CCError>) -> Void) {
        getTrendingCoins { [weak self] (result: Result<[Coin], CCError>) in
            switch result {
            case .success(let coins):
                for coin in coins {
                    self?.getDetails(for: coin.item.id) { (result: Result<Detail, CCError>) in
                        switch result {
                        case .success(let response):
                            coin.item.priceUsd = response.marketData.currentPrice["usd"] ?? 0.0
                            coin.item.description = response.description["en"] ?? ""
                            completed(.success(coins))
                        case .failure(let error):
                            completed(.failure(error))
                        }
                    }
                }
            case .failure(let error):
                completed(.failure(error))
            }
        }
    }
    
    private func getTrendingCoins(completed: @escaping (Result<[Coin], CCError>) -> Void) {
        let endpoint = baseUrl + "search/trending"
        fetchGenericJSONData(urlString: endpoint) { (result: Result<ItemResponse, CCError>) in
            switch result {
            case .success(let response):
                completed(.success(response.coins))
            case .failure(let error):
                completed(.failure(error))
            }
        }
    }
    
    func getDetails(for id: String, completed: @escaping (Result<Detail, CCError>) -> Void) {
        let endpoint = baseUrl + "coins/\(id)"
        fetchGenericJSONData(urlString: endpoint) { (result: Result<Detail, CCError>) in
            switch result {
            case .success(let response):
                completed(.success(response))
            case .failure(let error):
                completed(.failure(error))
            }
        }
    }
    
    func downloadImage(from urlString: String, completed: @escaping (UIImage?) -> Void) {
        let cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey) {
            completed(image)
            return
        }
        
        guard let url = URL(string: urlString) else {
            completed(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self,
                error == nil,
                let response = response as? HTTPURLResponse, response.statusCode == 200,
                let data = data,
                let image = UIImage(data: data) else {
                    completed(nil)
                    return
                }
            

            self.cache.setObject(image, forKey: cacheKey)
            completed(image)
        }
        
        task.resume()
    }
    
    private func fetchGenericJSONData<T: Decodable>(urlString: String, completed: @escaping (Result<T, CCError>) -> Void) {
        guard let url = URL(string: urlString) else {
            completed(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidResponse))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let decodedResponse = try decoder.decode(T.self, from: data)
                completed(.success(decodedResponse))
            } catch {
                print(error)
                completed(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
}
