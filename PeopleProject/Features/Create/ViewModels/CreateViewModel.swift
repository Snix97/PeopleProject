//
//  CreateViewModel.swift
//  PeopleProject
//
//  Created by Claire Roughan on 08/11/2024.
//

import Foundation

final class CreateViewModel: ObservableObject {
    
    //View will make changes to this via a Binding
    @Published var person = NewPerson()
    @Published private(set) var state: submissionState?
    
    func create() {
        
        let endcoder = JSONEncoder()
        endcoder.keyEncodingStrategy = .convertToSnakeCase
        
        //Convert Person into data
        let data = try? endcoder.encode(person)
        
        NetworkingManager.shared.request(methodType: .POST(data: data), "https://reqres.in/api/users") { [weak self] res in
            
            DispatchQueue.main.async {
               
                switch res {
                case .success:
                    self?.state = .successful
                case .failure(let error):
                    self?.state = .unsuccessful
                }
                
                print("DEBUG:- \(self?.state)")
            }
        }
    }
}

extension CreateViewModel {
    enum submissionState {
        case successful
        case unsuccessful
    }
}
