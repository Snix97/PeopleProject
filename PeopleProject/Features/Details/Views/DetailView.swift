//
//  DetailView.swift
//  PeopleProject
//
//  Created by Claire Roughan on 06/11/2024.
//

import SwiftUI

struct DetailView: View {
    var body: some View {
        ZStack {
            background
            
            ScrollView {
                VStack(alignment: .leading, spacing: 18) {
                    
                    VStack(alignment: .leading, spacing: 8) {
                        
                        Group{
                            //Makes these componets for cleaner/smarter code
                            generalUserInfo
                            link
                        }
                        .padding(.horizontal, 8)
                        .padding(.vertical, 18)
                        .background(Theme.detailBackground, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
                        
                        
                    }
                   
                }
                .padding()
            }
            
        }
       
    }
}

#Preview {
    DetailView()
}

private extension DetailView {
    
    //Computed property - used for styling
    var background: some View {
        Theme.background
            .ignoresSafeArea(edges: .top)
    }
    
    var link: some View {
        Link(destination: .init(string: "https://regres.in/#support-heading")!) {
            VStack(alignment: .leading, spacing: 0 ) {
                
                Text("Support Regres")
                    .foregroundColor(Theme.textColor)
                    .font(
                        .system(.body, design: .rounded)
                        .weight(.semibold)
                    )
                Text("https://regres.in/#support-heading")
                
            }
            
            Spacer()
            
            Symbols
                .link
                .font(.system(.title, design: .rounded))
        }
    }
}

private extension DetailView {
    
    var generalUserInfo: some View {
        VStack(alignment: .leading,
               spacing: 8) {
            
            PillView(id: 0)
            
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
        
        Text("<FirstName>")
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
        
        Text("<LastName>")
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
        
        Text("<Email>")
            .font(
                .system(.subheadline, design: .rounded)
            )
    }
}
