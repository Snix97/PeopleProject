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
    
    @State private var users: [User] = []
    
    //Defaults to false as dont want it presented automatically when view appears
    @State private var shouldShowCreatView = false
    
    var body: some View {
        NavigationView {
            ZStack {
                backGround
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(users, id: \.id) { user in
                            
                        //NavigationView is deprecated in iOS 16.0 This is the Pre iOS 16 way
                           NavigationLink {
                                DetailView()
                           } label: {
                               PersonItemView(user: user)
                           }
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
            
            //Get dummy data from embedded JSON files to prototype the Peopleview
            .onAppear {
                do {
                    let res = try StaticJSONMapper.decode(file: "UsersStaticData",
                                                          type: UsersResponse.self)
                    
                    users = res.data
                } catch {
                    //TODO: Handle errors
                    print(error)
                }
            }
            
            //Show creatView ontop of current PeopleView
            .sheet(isPresented: $shouldShowCreatView) {
                CreateView()
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
            shouldShowCreatView.toggle()
        } label: {
            Symbols.plus
                .font(
                    .system(.headline, design: .rounded)
                    .bold()
                )
        }
    }
}