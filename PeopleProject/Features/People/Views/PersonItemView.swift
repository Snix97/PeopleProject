//
//  PersonItemView.swift
//  PeopleProject
//
//  Created by Claire Roughan on 25/10/2024.
//

import SwiftUI

struct PersonItemView: View {
   
    let user: Int
    
    var body: some View {
        VStack(spacing: .zero) {
            
            Rectangle()
                .fill(.purple)
                .frame(height: 130)
            
            VStack(alignment: .leading) {
               
                PillView(id: user)
                
                Text("<FirstName> <LastName>")
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

#Preview {
    PersonItemView(user: 0)
        .frame(width: 250)
}
