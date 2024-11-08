//
//  PeopleViewModel.swift
//  PeopleProject
//
//  Created by Claire Roughan on 08/11/2024.
//

import Foundation

//Don't even think about subclassing me, ha, ha!
final class PeopleViewModel: ObservableObject {
    
   // Views can listen to this property but its not settable
    @Published private(set) var users: [User] = []
    
    func fetchUsers() {
        
        //[weak self] due to closure retain cycle
        NetworkingManager.shared.request("https://reqres.in/api/users", type: UsersResponse.self) { [weak self] res in
            
            DispatchQueue.main.async {
                switch res {
                case .success(let response):
                    self?.users = response.data
                    print(self?.users ?? "No user data")
                case .failure(let error):
                    print(error)
                }
            }
            
        }
    }

}
