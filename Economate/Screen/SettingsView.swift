//
//  SettingsView.swift
//  Economate
//
//  Created by Sualp Danacı on 28.04.2024.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("darkModeEnabled") private var darkModeEnabled = false
    @State private var notificationsEnabled = false
    @State private var selectedThemeIndex = 0
    @State private var showingAlert = false
    @State private var showingActionSheet = false
    private let themes = ["Light", "Dark", "System"]

    var body: some View {
        NavigationView {
            VStack{
                Form {
                    Section(header: Text("Appearance")) {
        
                        Toggle("Dark Mode", isOn: $darkModeEnabled)
                    }
                    
                    Section(header: Text("Notifications")) {
                        Toggle("Enable Notifications", isOn: $notificationsEnabled)
                    }
                    
                    Section(header: Text("Account")) {
                        Button(action: {
                            // Action for signing out
                            showingActionSheet = true
                        }) {
                            Text("Sign Out")
                                .foregroundColor(.red)
                                .font(.body)
                        }
                        .actionSheet(isPresented: $showingActionSheet) {
                            ActionSheet(title: Text("Are you sure you want to sign out?"), buttons: [
                                .destructive(Text("Sign Out")) {
                                    // Perform sign out action
                                    showingAlert = true
                                },
                                .cancel()
                            ])
                        }
                        .alert(isPresented: $showingAlert) {
                            Alert(title: Text("Signed Out"), message: Text("You have been signed out successfully."), dismissButton: .default(Text("OK")))
                        }
                        
                    }
                }
                
            }
            .navigationTitle("Settings")
        }
        .preferredColorScheme(darkModeEnabled ? .dark : .light)
        .edgesIgnoringSafeArea(.all)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .preferredColorScheme(.light)
    }
}
