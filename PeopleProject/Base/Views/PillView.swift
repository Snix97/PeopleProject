//
//  PillView.swift
//  PeopleProject
//
//  Created by Claire Roughan on 25/10/2024.
//

import SwiftUI

struct PillView: View {
    let id: Int
    var body: some View {
        Text("#\(id)")
            .font(.system(.caption, design:  .rounded) .bold()
            )
            .foregroundColor(.white)
            .padding(.horizontal, 9)
            .padding(.vertical, 4)
            .background(Theme.pill, in: Capsule())
    }
}

#Preview(traits: .sizeThatFitsLayout){
    PillView(id: 0)
        .padding()
       
}
