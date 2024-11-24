//
//  NetworkingManager.swift
//  PeopleProject
//
//  Created by Claire Roughan on 07/11/2024.
//

import Foundation

/*
 Singleton - create once, use anywhere avoids repetition of Networking  request logic
 Defined as a class as its a REFERENCE type.
 
 Request methods are OVERLOADED - same name but dif args to handle either GET or POST
 */

// cannot be overridden or subclassed
final class NetworkingManager {
    
    static let shared = NetworkingManager()
    
    private init() {}
    
    //GET request - Pass in URL and using Generics the type we wish to map the response to plus adaptable Error
    func request<T: Codable>(_ endPoint : Endpoint,
                             type: T.Type,
                             completion: @escaping (Result<T, Error>) -> Void)   {
        
        guard let url = endPoint.url else {
            completion(.failure(NetworkingError.invalidUrl))
            return
        }
        
        let request = buildRequest(from: url, methodType: endPoint.methodType)
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if error != nil {
                completion(.failure(NetworkingError.custom(error: error!))) //Force unwrap ok as we know we have one
                return
            }
            
            guard let response = response as? HTTPURLResponse,
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
    
    //POST request - We're only interested in statusCode of success. Sends back completion with success of void
    func request(_ endPoint: Endpoint,
                 completion: @escaping (Result<Void, Error>) -> Void)   {
        
        guard let url = endPoint.url else {
            completion(.failure(NetworkingError.invalidUrl))
            return
        }
        
        let request = buildRequest(from: url, methodType: endPoint.methodType)
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if error != nil {
                completion(.failure(NetworkingError.custom(error: error!)))
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                  (200...300) ~= response.statusCode else {
                let statusCode = (response as! HTTPURLResponse).statusCode
                completion(.failure(NetworkingError.invalidStatusCode(statusCode: statusCode)))
                return
            }
            
            completion(.success(()))
        }
        dataTask.resume()
        
    }
    
}

//Override LocalizedError to get more user friendly decription
extension NetworkingManager.NetworkingError {
    
    var errorDescription: String? {
        //Provide custom string description
        switch self {
        case .invalidUrl:
            return"URL isn't valid"
        case .invalidStatusCode:
            return"Status code falls into the wrong range"
        case .invalidData:
            return"Response data is invalid"
        case .failedToDecode:
            return"Failed to decode"
        case .custom(let err):
             return"Something went wrong \(err.localizedDescription)"
        }
    }
    
}
extension NetworkingManager {
    enum NetworkingError: LocalizedError {
        case invalidUrl
        case custom(error: Error)
        case invalidStatusCode(statusCode: Int)
        case invalidData
        case failedToDecode(error: Error)
    }
}

//Internal to NetworkingManager to retrieve the request method type
private extension NetworkingManager {
 
    func buildRequest(from url: URL, methodType: Endpoint.MethodType) -> URLRequest {
        
        var request = URLRequest(url: url)
        
        switch methodType {
        case .GET:
            request.httpMethod = "GET"
        case .POST(let data):
            request.httpMethod = "POST"
            request.httpBody = data
        }
        
        return request
    }
}
