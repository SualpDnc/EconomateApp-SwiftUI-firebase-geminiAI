//
//  FirebaseManager.swift
//  Economate
//
//  Created by Sualp Danacı on 26.05.2024.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseAuth



class FirebaseManager: NetworkManagerProtocol{
    
    
    let constantNeverUsed = FirebaseApp.configure()
    static let shared = FirebaseManager()
    
    let db = Firestore.firestore()
    
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    @Published var errorMessage: Error?
    @Published var showErrorAlert: Bool = false
    @Published var isLoggedIn: Bool = false
    @Published var isSignedUp: Bool = false
    
    
    private init(){
        self.userSession = Auth.auth().currentUser
    }
    
    func isThereAnyUser() -> Bool {
        Auth.auth().currentUser != nil
    }
    
    func signIn(withEmail email: String, password: String) async throws {
        do{
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            DispatchQueue.main.async {
                self.userSession = result.user
                self.isLoggedIn = true
            }
            
        } catch{
            DispatchQueue.main.async {
                self.errorMessage = error
//                self.showErrorAlert = true
            }
            
        }
        
    }
    
    func signUp(withEmail email: String, password: String) async throws {
          do {
             
              let result2 = try await Auth.auth().createUser(withEmail: email, password: password)
              DispatchQueue.main.async {
                  self.userSession = result2.user
                  self.isSignedUp = true
                  print("issignedup true")
              }
          } catch {
              DispatchQueue.main.async {
                  self.errorMessage = error
              }
          }
      }
      
    
    func signOut() {
        do{
            try Auth.auth().signOut()
            DispatchQueue.main.async {
                self.userSession = nil
                self.currentUser = nil
            }
        }catch{
            print("Failed to sign out!!")
        }
        print("User successfully Sign out")
    }
    
}
