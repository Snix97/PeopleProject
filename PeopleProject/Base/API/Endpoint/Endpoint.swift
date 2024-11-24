//
//  Endpoint.swift
//  PeopleProject
//
//  Created by Claire Roughan on 20/11/2024.
//

import Foundation

//For interacting with the different endpoints used in the app
enum Endpoint {
    case people
    case detail(id: Int) //Associated value
    case create(submissionData: Data?)
}

//Specify dif method types to pass into request functions
extension Endpoint {
    enum MethodType: Error {
        case GET
        case POST(data: Data?)
    }
}

extension Endpoint {
    
    //Main
    var host: String { "reqres.in" }
    
    //Manage the dif paths. Combine people and create as they have the same path
    var path: String {
        switch self {
        case .people,
             .create:
            return "/api/users"
        case .detail(let id):
            return "/api/users/\(id)"
        }
    }
    
    var methodType: MethodType {
        switch self {
        case .people,
             .detail:
            return .GET
        case .create(let data):
            return .POST(data: data)
        }
    }
}

//To build the URL
extension Endpoint {
    
    //Computed property
    var url: URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https" //Set to either http or https
        urlComponents.host = host
        urlComponents.path = path
        
        var requestQueryItems = [URLQueryItem]()
        
        //Used for debugging purposes
        #if DEBUG
        urlComponents.queryItems = [
            URLQueryItem(name: "delay", value: "3")
        ]
        #endif
        
        return urlComponents.url
    }
}
