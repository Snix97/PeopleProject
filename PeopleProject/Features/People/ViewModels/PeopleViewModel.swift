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
    
    //Handle Errors
    @Published private(set) var error: NetworkingManager.NetworkingError?
    @Published var hasError = false
    @Published private(set) var isLoading = false
    
    func fetchUsers() {
        isLoading = true
        
        //[weak self] due to closure retain cycle
        NetworkingManager.shared.request(.people, type: UsersResponse.self) { [weak self] res in
            
            DispatchQueue.main.async {
                defer {self?.isLoading = false}
                switch res {
                case .success(let response):
                    self?.users = response.data
                    print(self?.users ?? "No user data")
                case .failure(let error):
                    self?.hasError = true
                    self?.error = error as? NetworkingManager.NetworkingError
                }
            }
            
        }
    }

}
