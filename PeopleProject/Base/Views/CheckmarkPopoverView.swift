//
//  CheckmarkPopoverView.swift
//  PeopleProject
//
//  Created by Claire Roughan on 11/11/2024.
//

import SwiftUI

struct CheckmarkPopoverView: View {
    var body: some View {
        Symbols.checkmark
            .font(.system(.largeTitle, design: .rounded).bold())
            .padding()
            .foregroundStyle(.green)
            .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 10, style: .continuous))
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    CheckmarkPopoverView()
}
