//
//  CreateView.swift
//  PeopleProject
//
//  Created by Claire Roughan on 07/11/2024.
//

import SwiftUI

struct CreateView: View {
    
    //Creates an environment property to read the specified key path.
    @Environment(\.dismiss) private var dismiss
    
    //Property wrapper for tracking which view currently receives user input. Bound to Field enum to control movement between several input fields
    @FocusState private var focusedField: Field?
    @StateObject private var vm = CreateViewModel()
    
    let successfulAction: () -> Void
    
    var body: some View {
        NavigationView {
            Form {
                
                //Add section to get footer to show the exact form field validation error
                Section {
                    firstName
                    lastName
                    job
                } footer: {
                    if case .validationError(let err) = vm.error,
                         let errorDesc = err.errorDescription {
                          Text(errorDesc)
                              .foregroundStyle(.red)
                      }
                }

                Section {
                    submit
                }
            }
            //Prevent user interacting with the form after submit is pressed
            .disabled(vm.state == .submitting)
            .navigationTitle("Create")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    done
                }
            }
            
            .onChange(of: vm.state) { formState in
                
                print("DEBUG:- \(String(describing: vm.state))")
                
                // Dismiss after successful post when press submit button
                if formState == .successful {
                    dismiss()
                    successfulAction()
                }
            }
            //Don't have retry action here we just want an OK to dismiss the alert else we'd get stuck in a retry loop
            .alert(isPresented: $vm.hasError,
                   error: vm.error) { }
            .overlay {
            
                if vm.state == .submitting {
                    ProgressView()
                }
            }
        }
    }
}

#Preview {
    CreateView {}
}

extension CreateView {
    enum Field: Hashable {
        case firstName
        case lastName
        case job
    }
}

private extension CreateView {
    
    var done: some View {
        Button("Done") {
            //Can dismiss by dragging view down, but give users button action option too
            dismiss()
        }
    }
    
    var firstName: some View {
        TextField("First name", text: $vm.person.firstName)
            .focused($focusedField, equals: .firstName)
           
    }
    
    var lastName: some View {
       
        TextField("Last name", text: $vm.person.lastName)
            .focused($focusedField, equals: .firstName)
    }
    
    var job: some View {
        TextField("Job", text: $vm.person.job)
            .focused($focusedField, equals: .firstName)
    }
    
    var submit: some View {
        Button("Submit") {
            focusedField = nil //resign focused fields
            vm.create()
        }
    }
}
