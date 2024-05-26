//
//  ProfileView.swift
//  Economate
//
//  Created by Sualp Danacı on 28.04.2024.
//

import SwiftUI

struct ProfileView: View {
    @State private var showingAlert = false
    @State private var showingActionSheet = false
    
    var body: some View {
        VStack {
            Text("Profile")
                .bold()
                .font(.largeTitle)
                .padding()
                .foregroundColor(.teal)
              
            
            Image(systemName: "person.circle.fill")
                .resizable()
                .foregroundColor(.teal)
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
                .offset(y:40)
            Spacer()
       
            
            ProfileDetailRow(iconName: "envelope.fill", label: "Email", value: "user@example.com")
            ProfileDetailRow(iconName: "key.fill", label: "Password", value: "********")
            ProfileDetailRow(iconName: "calendar", label: "Join Date", value: "January 1, 2024")
            
     
            Spacer()
            
            Button(action: {
                // Action for signing out
                showingActionSheet = true
            }) {
                Text("Sign Out")
                    .foregroundColor(.red)
                    .font(.title)
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
        .padding()
    }
}

struct ProfileDetailRow: View {
    var iconName: String
    var label: String
    var value: String
    
    var body: some View {
        HStack {
            Image(systemName: iconName)
                .foregroundColor(.blue)
                .frame(width: 30, height: 50)
            Text(label)
                .font(.body)
                .foregroundColor(.primary)
            Spacer()
            Text(value)
                .foregroundColor(.secondary)
                .font(.body)
        }
        .padding(.horizontal)
        .padding(.vertical, 5)
        .offset(y: -70)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

