//
//  Model.swift
//  PeopleProject
//
//  Created by Claire Roughan on 22/10/2024.
//

import Foundation

//File holds models shared by different/multiple features

// MARK: - User
struct User: Codable {
    let id: Int?
    let email: String?
    let firstName: String?
    let lastName: String?
    let avatar: String?

}

// MARK: - Support
struct Support: Codable {
    let url: String?
    let text: String?
}
