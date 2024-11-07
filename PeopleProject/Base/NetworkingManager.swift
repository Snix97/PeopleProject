//
//  NetworkingManager.swift
//  PeopleProject
//
//  Created by Claire Roughan on 07/11/2024.
//

import Foundation

/*
 Singleton - create once, use anywhere avoids repetition of Networking  request logic
 Defined as a class as its a REFERENCE type
 */

// cannot be overridden or subclassed
final class NetworkingManager {
    
    static let shared = NetworkingManager()
    
    private init() {}
    
    //TODO: Initial basic request code - will improve with Generics
    func request(_ absoluteUrl: String) {
        
        let url = URL(string: absoluteUrl)
        let request = URLRequest(url: url!)
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if error != nil { return }
            
            guard let response = response as? HTTPURLResponse,
                !(200...300).contains(response.statusCode)  else {
                return
            }
            
            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase //Avoids need for using codingKeys in models
                let res = try decoder.decode(UsersResponse.self, from: data)
                
            } catch {
                print(error)
            }
            
        }
        dataTask.resume()
        
        
        
    }
    
}
