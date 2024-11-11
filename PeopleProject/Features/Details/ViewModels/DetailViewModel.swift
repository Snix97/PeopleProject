//
//  DetailViewModel.swift
//  PeopleProject
//
//  Created by Claire Roughan on 08/11/2024.
//

import Foundation

final class DetailViewModel: ObservableObject {
    
    // Views can listen to this property but its not settable
    @Published private(set) var userInfo: UserDetailResponse?
    
    //Handle Errors
    @Published private(set) var error: NetworkingManager.NetworkingError?
    @Published var hasError = false
    
    func fetchDetails(for id: Int) {
        
        NetworkingManager.shared.request("https://reqres.in/api/users/\(id)x", type: UserDetailResponse.self) { [weak self] res in
            
            DispatchQueue.main.async {
                switch res {
                case .success(let response):
                    self?.userInfo = response
                    print(self?.userInfo ?? "No user data")
                case .failure(let error):
                    self?.hasError = true
                    self?.error = error as? NetworkingManager.NetworkingError
                }
            }
            
        }
        
    }
}
