//
//  Model.swift
//  PeopleProject
//
//  Created by Claire Roughan on 22/10/2024.
//

import Foundation

//File holds models shared by different/multiple features

import Foundation

// MARK: - User
struct User: Codable, Equatable {
    let id: Int
    let email, firstName, lastName: String
    let avatar: String
}

// MARK: - Support
struct Support: Codable, Equatable {
    let url: String
    let text: String
}
