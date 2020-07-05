//
//  NetworkService.swift
//  WeatherTestApp
//
//  Created by Alexander Spirichev on 04.07.2020.
//  Copyright © 2020 Alexander Spirichev. All rights reserved.
//

import Foundation

class NetworkService {
    
    #warning("Add your API key")
    private let secretApiKey = ""
    
    func weather(for cityId: Int, completion: @escaping (Result<Weather, Error>) -> Void) {
        guard !secretApiKey.isEmpty else {
            completion(.failure(.apiKeyIsMissing))
            return
        }
        
        let urlString = "https://api.openweathermap.org/data/2.5/weather?id=\(cityId)&appid=\(secretApiKey)&units=metric"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(.badUrl))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completion(.failure(.network))
                return
            }
            
            if let data = data {
                do {
                    let weather = try JSONDecoder().decode(Weather.self, from: data)
                    completion(.success(weather))
                } catch {
                    completion(.failure(.dataCorrupted))
                }
            }
        }.resume()
    }
}

extension NetworkService {
    enum Error: Swift.Error, LocalizedError {
        case badUrl
        case network
        case dataCorrupted
        case apiKeyIsMissing
        
        var errorDescription: String? {
            localizedDescription
        }
        
        var localizedDescription: String {
            switch self {
                case .badUrl:
                    return "Wrong city"
                
                case .network:
                    return "Network error"
                
                case .dataCorrupted:
                    return "Invalid data format"
                
                case .apiKeyIsMissing:
                    return "Insert your API key"
            }
        }
    }
}
