//
//  SettingsView.swift
//  PeopleProject
//
//  Created by Claire Roughan on 13/11/2024.
//

/*
 Enables users to turn off Haptic feedback 
 */
import SwiftUI

struct SettingsView: View {
    
    //Access userDefaults - haptic enabled defaults to true, user can turn this off in the settings screen
    @AppStorage(UserDefaultKeys.hapticsEnabled) private var isHapticsEnabled: Bool = true
    var body: some View {
        NavigationView {
            Form {
                haptics
            }
            .navigationTitle("Settings")
        }
    }
}

private extension SettingsView {
    var haptics: some View {
        Toggle("Enable Haptics", isOn: $isHapticsEnabled)
    }
}


#Preview {
    SettingsView()
}

