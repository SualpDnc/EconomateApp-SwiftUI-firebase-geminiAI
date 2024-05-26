//
//  ContentView.swift
//  Economate
//
//  Created by Sualp Danacı on 28.04.2024.
//

import SwiftUI

struct SignView: View {
    
    @StateObject private var viewModel = SignViewModel()
    
    var body: some View {
            VStack {
               
                Image("economate-logo")
                    .resizable()
                    .frame(width: 170, height: 110)
                    .offset(y:-90)
                
                Text("Welcome, please sign in.")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding(.bottom, 35)

                TextField("Email", text: $viewModel.email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal).padding(.bottom,10)
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)
                
                TextField("Name", text: $viewModel.name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal).padding(.bottom,10)
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)
                    .padding(.top,7)
                    
                    
                SecureField("Password", text: $viewModel.password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding().padding(.top,-10)
                
                Button(action: {
                    viewModel.loginTapped()
//                    $viewModel.showingMainView.toggle()
                              }) {
                                  Text("Sign In")
                                      .frame(minWidth: 200, maxWidth:200)
                                      .frame(height: 40)
                                      .foregroundColor(.white)
                                      .font(.system(size: 17, weight: .bold))
                                      .background(Color.blue)
                                      .cornerRadius(25)
                                      .padding(.horizontal)
                              }
                              .fullScreenCover(isPresented: $viewModel.showingMainView) {
                                  MainView()
                }
                
                Button("Don't have an account? Sign Up") {
//                    $viewModel.showingSignUp.toggle()
                }
                .sheet(isPresented: $viewModel.showingSignUp) {
                    SignUpView()
                }
                .padding().padding(.top,20)
            }
            .padding()

    }
}

struct SignUpView: View {
    @State private var email = ""
    @State private var password = ""
    var body: some View {
        Text("Sign Up")
            .font(.title)
            .fontWeight(.semibold)
            .padding(.bottom, 35)

        TextField("Email", text: $email)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding(.horizontal).padding(.bottom,10)
            .autocapitalization(.none)
            .keyboardType(.emailAddress)
            
        SecureField("Password", text: $password)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding().padding(.bottom,10)
        Button(action: {
                    
                }) {
                    Text("Sign Up")
                        .frame(minWidth: 200, maxWidth:200)
                        .frame(height: 40)
                        .foregroundColor(.white)
                        .font(.system(size: 17, weight: .bold))
                        .background(Color.blue)
                        .cornerRadius(25)
                        .padding(.horizontal)
                }
                 
        }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignView().preferredColorScheme(.light)
    }
}
