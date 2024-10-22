//
//  ContentView.swift
//  PeopleProject
//
//  Created by Claire Roughan on 15/10/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Hello, world!")
                .padding()
                .onAppear {
                  
                    print("DEBUG: Users response")
                    dump {
                        try? StaticJSONMapper.decode(file: "UsersStaticData", type: UsersResponse.self)
                    }
                    
                    print("DEBUG: Single Users response")
                    dump {
                        try? StaticJSONMapper.decode(file: "SingleUserData", type: UserDetailResponse.self)
                    }
                    
                }
        }
        
    }
}

#Preview {
    ContentView()
}
