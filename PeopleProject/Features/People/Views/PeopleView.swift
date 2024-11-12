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
    
    @StateObject private var vm = PeopleViewModel()
    
    //Defaults to false as dont want it presented automatically when view appears
    @State private var shouldShowCreatView = false
    
    @State private var shouldShowSuccess = false
    
    var body: some View {
        NavigationView {
            ZStack {
                backGround
                if vm.isLoading {
                    ProgressView()
                } else {
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(vm.users, id: \.id) { user in
                                
                                //NavigationView is deprecated in iOS 16.0 This is the Pre iOS 16 way
                                NavigationLink {
                                    DetailView(userId: user.id)
                                } label: {
                                    PersonItemView(user: user)
                                }
                            }
                        }
                        .padding()
                    }
                }
            }
            //Title can't be applied onto the actual navView it has to be on one of its children, in this case the ZStack
            .navigationTitle("People")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    createNewUser
                }
            }
            
            
            .onAppear {
                
                /*
                 //Get dummy data from embedded JSON files to prototype the Peopleview
                 do {

                     let res = try StaticJSONMapper.decode(file: "UsersStaticData",
                                                           type: UsersResponse.self)
                     users = res.data
                 } catch { print(error) }
                 */

                //Get real API data from ViewModel
                vm.fetchUsers()
            }
            
            //Show creatView ontop of current PeopleView
            .sheet(isPresented: $shouldShowCreatView) {
                CreateView {
                    //Implemnet closure that submission was success and show CheckmarkPopoverView with an animation
                    withAnimation(.spring().delay(0.25)) {
                        //Set to true
                        self.shouldShowSuccess.toggle()
                    }
                }
            }
            .alert(isPresented: $vm.hasError, error: vm.error) {
                Button("Retry") {
                    vm.fetchUsers()
                }
            }
            .overlay {
                if shouldShowSuccess {
                    CheckmarkPopoverView()
                    //Add extra to animation to make in shrink and fade
                        .transition(.scale.combined(with: .opacity))
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                withAnimation(.spring()) {
                                    //Set to false
                                    self.shouldShowSuccess.toggle()
                                }
                            }
                    }
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
            shouldShowCreatView.toggle()
        } label: {
            Symbols.plus
                .font(
                    .system(.headline, design: .rounded)
                    .bold()
                )
        }
        //Disable access to CreateView when dta is still loading
        .disabled(vm.isLoading)
    }
}
