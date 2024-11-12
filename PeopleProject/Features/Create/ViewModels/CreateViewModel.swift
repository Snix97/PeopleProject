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
    @Published private(set) var state: SubmissionState?
    
    //Handle Errors - formError handles both networking & form
    @Published private(set) var error: FormError?
    @Published var hasError = false
    
    private let validator = CreateValidator()
    
    func create() {
        
        do {
            try validator.validate(person)
            
            state = .submitting
            
            let endcoder = JSONEncoder()
            endcoder.keyEncodingStrategy = .convertToSnakeCase
            
            //Convert Person into data
            let data = try? endcoder.encode(person)
            
            //Can add a delay - "https://reqres.in/api/users?delay=5"
            NetworkingManager.shared.request(methodType: .POST(data: data), "https://reqres.in/api/users") { [weak self] res in
                
                DispatchQueue.main.async {
                   
                    switch res {
                    case .success:
                        self?.state = .successful
                    case .failure(let error):
                        self?.state = .unsuccessful
                        self?.hasError = true
                        
                        //Force unwrap as it has to be of type NetworkingError
                        // self?.error = .networkingError(error: error as! NetworkingManager.NetworkingError)
                        
                        //Safer way to get error
                        if let networkingError = error as? NetworkingManager.NetworkingError {
                            self?.error = .networkingError(error: networkingError)
                        }
                        
                    }
                    
                    print("DEBUG:- \(String(describing: self?.state))")
                }
            }
        } catch {
            self.hasError = true
            if let validationError = error as? CreateValidator.CreateValidatorError {
                self.error = .validationError(error: validationError)
            }
        }
        
        
    }
}

extension CreateViewModel {
    enum SubmissionState {
        case successful
        case unsuccessful
        case submitting
    }
}

//Enable both form and network errors to be handled
extension CreateViewModel {
    enum FormError: LocalizedError {
        case networkingError(error: LocalizedError)
        case validationError(error: LocalizedError)
    }
}

//Get error description
extension CreateViewModel.FormError {
    var errorDescription: String? {
        switch self {
        case .networkingError(let err),
                .validationError(let err):
            return err.localizedDescription
        }
    }
}
