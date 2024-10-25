//
//  PeopleProjectApp.swift
//  PeopleProject
//
//  Created by Claire Roughan on 15/10/2024.
//

import SwiftUI

@main
struct PeopleProjectApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                PeopleView()
                    .tabItem {
                        Symbols.person
                        Text("Home")
                    }
            }
            
        }
    }
}
