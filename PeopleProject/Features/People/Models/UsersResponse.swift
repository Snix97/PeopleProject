//
//  UsersResponse.swift
//  PeopleProject
//
//  Created by Claire Roughan on 22/10/2024.
//

// MARK: - UsersResponse
struct UsersResponse: Codable {
    let page: Int?
    let perPage: Int?
    let total: Int?
    let totalPages: Int?
    let data: [User]?
    let support: Support?

}

