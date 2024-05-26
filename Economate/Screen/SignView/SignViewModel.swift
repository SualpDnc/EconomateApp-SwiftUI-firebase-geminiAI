//
//  SignViewModel.swift
//  Economate
//
//  Created by Sualp Danacı on 23.05.2024.
//

import Foundation

class SignViewModel: ObservableObject {
    
    @Published var email = ""
    @Published var name = ""
    @Published var password = ""
    @Published var showingSignUp = false
    @Published var showingMainView = false
    @Published var showAlert = false
    
    var user = User(userId: "", password: "")
    
    func loginTapped(){
         
         if email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || password.isEmpty {
              showAlert = true
              print("Email or password is empty")
              return
         }
         
         Task{
              do{
                   try await FirebaseManager.shared.signIn(withEmail: email, password: password)
                   DispatchQueue.main.async {
//                        self.errorMessage = FirebaseManager.shared.errorMessage?.localizedDescription ?? ""
//                        self.showWrongAlert = FirebaseManager.shared.showErrorAlert
                   //Navigate to Home Page
                   }
              }
              catch{
                   print("Error occurs at sign in")
              }
         }
    }
}
