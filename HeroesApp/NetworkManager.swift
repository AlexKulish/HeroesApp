//
//  NetworkManager.swift
//  HeroesApp
//
//  Created by Alex Kulish on 17.02.2022.
//

import Foundation

enum NetworkError: Error {
    case invalidUrl
    case noData
    case decodingError
}

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchData(completion: @escaping(Result<[Hero], NetworkError>) -> Void) {
        
        guard let url = URL(string: "https://cdn.rawgit.com/akabab/superhero-api/0.2.0/api/all.json") else {
            completion(.failure(.invalidUrl))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                completion(.failure(.noData))
                print(error?.localizedDescription ?? "No error description ")
                return
            }
            
            do {
                let heroes = try JSONDecoder().decode([Hero].self, from: data)
                DispatchQueue.main.async {
                    completion(.success(heroes))
                }
            } catch {
                completion(.failure(.decodingError))
                print(error.localizedDescription)
                print("3")
            }
        }.resume()
    }
    
    func fetchImage(from url: URL, completion: @escaping(Result<Data, NetworkError>) -> Void) {
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                completion(.failure(.noData))
                print(error?.localizedDescription ?? "No error description ")
                return
            }
            
            DispatchQueue.main.async {
                completion(.success(data))
            }
        }.resume()
    }
}
