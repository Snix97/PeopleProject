//
//  DetailView.swift
//  PeopleProject
//
//  Created by Claire Roughan on 06/11/2024.
//

import SwiftUI

struct DetailView: View {
    
    let userId: Int
    
    @StateObject private var vm = DetailViewModel()
    
    var body: some View {
        ZStack {
            background
            
            ScrollView {
                VStack(alignment: .leading, spacing: 18) {
                    
                    avatar
                        
                    Group{
                        //Makes these componets for cleaner/smarter code
                        generalUserInfo
                        link
                    }
                    .padding(.horizontal, 8)
                    .padding(.vertical, 18)
                    .background(Theme.detailBackground, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
               
                }
                .padding()
            }
        }
        .navigationTitle("Details")
        
        .onAppear {
            //Get dummy data from embedded JSON files to prototype the Detailview
//            do {
//                userInfo = try StaticJSONMapper.decode(file: "SingleUserData",
//                                                      type: UserDetailResponse.self)
//    
//            } catch {
//                //TODO: Handle errors
//                print(error)
//            }
            
            //Get real API data from the DetailViewModel
            vm.fetchDetails(for: userId)
        }
       
    }
}

#Preview {
    //Use local JSON to get a userId just to use for the preview
    var previewUserId: Int {
        let users = try! StaticJSONMapper.decode(file: "UsersStaticData", type: UsersResponse.self)
        return users.data.first!.id
    }
    
    NavigationView {
        DetailView(userId: previewUserId)
    }
}

private extension DetailView {
    
    //Computed property - used for styling
    var background: some View {
        Theme.background
            .ignoresSafeArea(edges: .top)
    }
    
    @ViewBuilder
    var avatar: some View {
        if let avatarAbsoluteString = vm.userInfo?.data.avatar,
           let avatarUrl = URL(string: avatarAbsoluteString) {
            
            AsyncImage(url: avatarUrl) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 250)
                    .clipped() // Keep simage in bounds
                    
            } placeholder: {
                ProgressView()
            }
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            .shadow(color: Theme.pill, radius: 10, x: 10, y: 0)
        }
    }
    
    @ViewBuilder
    var link: some View {
        
        if let supportAbsoluteString = vm.userInfo?.support.url,
           let supportUrl = URL(string: supportAbsoluteString),
           let supportTxt = vm.userInfo?.support.text {
            
            Link(destination: supportUrl) {
                
                VStack(alignment: .leading,
                       spacing: 8) {
                    
                    Text(supportTxt)
                        .foregroundColor(Theme.textColor)
                        .font(
                            .system(.body, design: .rounded)
                            .weight(.semibold)
                        )
                        .multilineTextAlignment(.leading)
                    
                    Text(supportAbsoluteString)
                    
                }
                
                Spacer()
                
                Symbols
                    .link
                    .font(.system(.title3, design: .rounded))
                
            }
            
        }
    }
}

private extension DetailView {
    
    var generalUserInfo: some View {
        VStack(alignment: .leading,
               spacing: 8) {
            
            PillView(id: vm.userInfo?.data.id ?? 0)
            
            //Using Group enables you to to apply the same modifier in many places all at once, by setting it on the entire group
            Group {
                firstName
                lastName
                email
            }
            .foregroundColor(Theme.textColor)
        }
    }
    
    //The @ViewBuilder attribute allows you to define the body of a SwiftUI view without using a return keyword in front of every view contained in your custom component so you can return 1 or more views
    
    @ViewBuilder
    var firstName: some View {
        
        Text("First Name")
            .font(
                .system(.body, design: .rounded)
                .weight(.semibold)
            )
        
        Text(vm.userInfo?.data.firstName ?? "-")
            .font(
                .system(.subheadline, design: .rounded)
            )
        
        Divider()
    }
    
    @ViewBuilder
    var lastName: some View {
        Text("LastName")
            .font(
                .system(.body, design: .rounded)
                .weight(.semibold)
            )
        
        Text(vm.userInfo?.data.lastName ?? "-")
            .font(
                .system(.subheadline, design: .rounded)
            )
        
        Divider()
    }
    
    
    @ViewBuilder
    var email: some View {
        Text("Email")
            .font(
                .system(.body, design: .rounded)
                .weight(.semibold)
            )
        
        Text(vm.userInfo?.data.email ?? "-")
            .font(
                .system(.subheadline, design: .rounded)
            )
    }
}
