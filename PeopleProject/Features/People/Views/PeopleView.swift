//
//  PeopleView.swift
//  PeopleProject
//
//  Created by Claire Roughan on 22/10/2024.
//

import SwiftUI

struct PeopleView: View {
    
    //For CollectionView!
    private let columns = Array(repeating: GridItem(.flexible()), count: 2)
    
    var body: some View {
        NavigationView {
            ZStack {
                backGround
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(0...5, id: \.self) { item in
                            
                            PersonItemView(user: item)
                        }
                    }
                    .padding()
                }
            }
            //Title can't be applied onto the actual navView it has to be on one of its children, in this case the ZStack
            .navigationTitle("People")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    createNewUser
                }
            }
        }
       
    }
}

#Preview {
    PeopleView()
}

// Extract views into components
private extension PeopleView {
    
    //computed properties to return some kind of view
    var backGround: some View {
        Theme.background
            .ignoresSafeArea(edges: .top)
    }
    
   
    //For ToolBar item
    var createNewUser: some View {
        Button {
            
        } label: {
            Symbols.plus
                .font(
                    .system(.headline, design: .rounded)
                    .bold()
                )
        }
    }
}
