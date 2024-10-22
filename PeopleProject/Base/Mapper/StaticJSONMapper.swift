//
//  StaticJSONMapper.swift
//  PeopleProject
//
//  Created by Claire Roughan on 22/10/2024.
//

import Foundation

/*
 Has function to handle decoding of the static JSON files - helps in prototyping the app
 */

struct StaticJSONMapper {
   
    //Enables passing in any type that conforms to Decodable so we can tell the func what type to decode and model to return. Decode any JSON file to the type we pass in
    static func decode<T: Decodable>(file: String, type: T.Type) throws -> T {
        
        //Get JSON file from app bunble
        guard let path = Bundle.main.path(forResource: file, ofType: "json"),
              let data = FileManager.default.contents(atPath: path) else {
            throw MappingError.failedToGetContents
        }
        
        //Decode the data
        let decoder = JSONDecoder()
        
        //Having this means we don't need to have coding keys in our models
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let result = try decoder.decode(T.self, from: data)
        
        print(result)
        return result
        
    }
}

extension StaticJSONMapper {
    enum MappingError: Error {
        case failedToGetContents
    }
}




