//
//  ProfileView.swift
//  Economate
//
//  Created by Sualp Danacı on 28.04.2024.
//

import SwiftUI

struct ProfileView: View {
    
    @StateObject private var viewModel = ProfileViewModel()
    
    @State private var showingAlert = false
    @State private var showingActionSheet = false
    
    var body: some View {
        VStack {
            if let user = viewModel.user {
                
                Text("\(user.firstName) \(user.lastName)")
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
                
                ProfileDetailRow(iconName: "envelope.fill", label: "Email", value: user.email)
                ProfileDetailRow(iconName: "key.fill", label: "Password", value: "********")
                ProfileDetailRow(iconName: "calendar", label: "Join Date", value: "January 1, 2024")
                
                Spacer()
                
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text("Signed Out"), message: Text("You have been signed out successfully."), dismissButton: .default(Text("OK")))
                }
                
            }
            
        }.onAppear(){
            viewModel.fetchUser()
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

