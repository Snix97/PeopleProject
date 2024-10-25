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
                Theme.background
                    .ignoresSafeArea(edges: .top)
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(0...5, id: \.self) { item in
                            
                            VStack(spacing: .zero) {
                                
                                Rectangle()
                                    .fill(.purple)
                                    .frame(height: 130)
                                
                                VStack(alignment: .leading) {
                                    
                                    Text("#\(item)")
                                        .font(.system(.caption, design:  .rounded) .bold()
                                        )
                                        .foregroundColor(.white)
                                        .padding(.horizontal, 9)
                                        .padding(.vertical, 4)
                                        .background(Theme.pill, in: Capsule())
                                    
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
                   
                }
                .padding()
               
            }
            //Title can't be applied onto the actual navView it has to be on one of its children, in this case the ZStack
            .navigationTitle("People")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
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
        }
       
    }
}

#Preview {
    PeopleView()
}
