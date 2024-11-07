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
    
    //Pass in URL and using Generics the type we wish to map the response to plus adaptable Error
    func request<T: Codable>(_ absoluteUrl: String, type: T.Type, completion: @escaping (Result<T, Error>) -> Void)   {
        
        guard let url = URL(string: absoluteUrl) else {
            completion(.failure(NetworkingError.invalidUrl))
            return
        }
        
        let request = URLRequest(url: url)
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if error != nil {
                completion(.failure(NetworkingError.custom(error: error!))) //Force unwrap ok as we know we have one
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                  //!(200...300).contains(response.statusCode)  else {
                  (200...300) ~= response.statusCode else {
                let statusCode = (response as! HTTPURLResponse).statusCode
                completion(.failure(NetworkingError.invalidStatusCode(statusCode: statusCode)))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkingError.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase //Avoids need for using codingKeys in models
                let res = try decoder.decode(T.self, from: data)
                completion(.success(res))
                
            } catch {
                completion(.failure(NetworkingError.failedToDecode(error: error)))
            }
            
        }
        dataTask.resume()

    }
    
}

extension NetworkingManager {
    enum NetworkingError: Error {
        case invalidUrl
        case custom(error: Error)
        case invalidStatusCode(statusCode: Int)
        case invalidData
        case failedToDecode(error: Error)
    }
     
}
