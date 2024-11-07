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
    
    var body: some View {
        NavigationView {
            Form {
                
                firstName
                lastName
                job
                
                Section {
                    submit
                }
            }
            .navigationTitle("Create")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    done
                }
            }
        }
    }
}

#Preview {
    CreateView()
}

private extension CreateView {
    
    var done: some View {
        Button("Done") {
            //Can dismiss by dragging view down, but give users button action option too
          dismiss()
        }
    }
    
    var firstName: some View {
        //Not give value to bind too just yet, will do when hook up to viewModel later
        TextField("First name", text: .constant(""))
    }
    
    var lastName: some View {
       
        TextField("Last name", text: .constant(""))
    }
    
    var job: some View {
        TextField("Job", text: .constant(""))
    }
    
    var submit: some View {
        Button("Submit") {
          //TODO: Handle action
        }
    }
}
