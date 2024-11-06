//
//  PersonItemView.swift
//  PeopleProject
//
//  Created by Claire Roughan on 25/10/2024.
//

import SwiftUI

struct PersonItemView: View {
   
    let user: User
    
    var body: some View {
        VStack(spacing: .zero) {
            
            //AsynchImage - iOS 15
            AsyncImage(url: .init(string: user.avatar)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 130)
                    .clipped()
            } placeholder: {
                ProgressView()
            }
            
            VStack(alignment: .leading) {
               
                PillView(id: user.id)
                
                Text("\(String(describing: user.firstName)) \(String(describing: user.lastName))")
                    .foregroundColor(Theme.textColor)
                    .font(
                        .system(.body, design: .rounded)
                    
                    )
                
            }
            .frame(maxWidth: .infinity,
                   alignment: .leading)
            .padding(.horizontal, 6)
            .padding(.vertical, 4)
            .background(Theme.detailBackground)
        }
        .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
        .shadow(color: Theme.textColor.opacity(0.1), radius: 2, x: 0, y: 2)
    }
}

struct PersonItemView_Previews: PreviewProvider {
    
    static var previewUser: User {
       let users = try! StaticJSONMapper.decode(file: "UsersStaticData",
                                            type: UsersResponse.self)
        return (users.data.first!)
    }
    
    static var previews: some View {
        PersonItemView(user: previewUser)
            .frame(width: 250)
    }
}

