//
//  ContentView.swift
//  Economate
//
//  Created by Sualp Danacı on 28.04.2024.
//

import SwiftUI
import Firebase
import FirebaseFirestore

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        FirebaseApp.configure()
        let db = Firestore.firestore()
        
        return true
    }
}


struct SignView: View {
    
    @State var showingSignUp = false
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
//
//                TextField("Name", text: $viewModel.name)
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
//                    .padding(.horizontal).padding(.bottom,10)
//                    .autocapitalization(.none)
//                    .keyboardType(.emailAddress)
//                    .padding(.top,7)
                    
                    
                SecureField("Password", text: $viewModel.password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding().padding(.top,-10)
                
                Button(action: {
                    viewModel.loginTapped()
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
                              .alert(isPresented: $viewModel.showAlert) {
                                   Alert(title: Text("Warning"),
                                         message: Text("Email and password can not be empty."),
                                         dismissButton:
                                             .default(Text("OK"))
                                   )
                              }
                              .alert(isPresented: $viewModel.showWrongAlert) {
                                   Alert(title: Text("Warning"),
                                         message: Text("Email or password is wrong."),
                                         dismissButton:
                                             .default(Text("OK"))
                                   )
                              }
                
                              .fullScreenCover(isPresented: $viewModel.isLoggedIn) {
                                  MainView()
                              }
                
                Button("Don't have an account? Sign Up") {
                    showingSignUp.toggle()
                }
                .sheet(isPresented: $showingSignUp) {
                    SignUpView()
                }
                .padding().padding(.top,20)
            }
            .padding()
        
        if viewModel.isLoading {
                   Color.black.opacity(0)
                       .edgesIgnoringSafeArea(.all)
                   
                   ProgressView("Loading...")
                       .progressViewStyle(CircularProgressViewStyle())
                       .scaleEffect(1.5, anchor: .center)
               }
    }
}

struct SignUpView: View {
    @State private var email = ""
    @State private var password = ""
    @StateObject private var viewModel = SignViewModel()
    var body: some View {
        Text("Sign Up")
            .font(.title)
            .fontWeight(.semibold)
            .padding(.bottom, 35)

        TextField("Email", text: $viewModel.emailF)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding(.horizontal).padding(.bottom,10)
            .autocapitalization(.none)
            .keyboardType(.emailAddress)
            
        SecureField("Password", text: $viewModel.passwordF)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding().padding(.bottom,10)
        Button(action: {
            viewModel.signUpTapped()
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
                .alert(isPresented: $viewModel.isSignedUp) {
                     Alert(title: Text("Warning"),
                           message: Text("Successfully signed up."),
                           dismissButton:
                               .default(Text("OK"))
                     )
                }
                 
        }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignView().preferredColorScheme(.light)
    }
}
