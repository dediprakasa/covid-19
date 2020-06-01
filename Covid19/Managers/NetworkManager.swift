//
//  NetworkManager.swift
//  Covid19
//
//  Created by Dedi Prakasa on 5/6/20.
//  Copyright © 2020 Dedi Prakasa. All rights reserved.
//

import Foundation
import Alamofire

struct Countries: Decodable {
    let countries: [Country]
}

class NetworkManager {
    
    static let shared = NetworkManager()
    
    func getMyCountryData(country: String, completion: @escaping (Result<MathdroidAPIResponse, Error>)-> Void) {
        let host = "covid19.mathdro.id"
        var components = URLComponents()
        components.scheme = "https"
        components.host = host
        
        if country == "Worldwide" {
            components.path = "/api"
        } else {
            components.path = "/api/countries/\(country)"
        }
        
        guard let url = components.url else {
            print("Failed when creating URL")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, rawResponse, error) in
            
            if error != nil {
                print("cuk")
                return
            }
            
            guard let response = rawResponse as? HTTPURLResponse else {
                return
            }
            
            if !(200...299).contains(response.statusCode) {
                print("Something went wrong")
            }
            
            guard let data = data else {
                print("----")
                
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let math = try decoder.decode(MathdroidAPIResponse.self, from: data)
                completion(.success(math))
                
            } catch {
                print("-----xx")
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    func getCountries(completion: @escaping (Result<Countries, Error>) -> Void) {
        let host = "covid19.mathdro.id"
        var components = URLComponents()
        components.scheme = "https"
        components.host = host
        components.path = "/api/countries"
        
        guard let url = components.url else {
            print("Failed when creating URL")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, rawResponse, error) in
            
            if error != nil {
                print("cuk")
                return
            }
            
            guard let response = rawResponse as? HTTPURLResponse else {
                return
            }
            
            if !(200...299).contains(response.statusCode) {
                print("Something went wrong")
            }
            
            guard let data = data else {
                print("----")
                
                return
            }
            
            do {
                print(data)
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let countries = try decoder.decode(Countries.self, from: data)
                completion(.success(countries))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
}
