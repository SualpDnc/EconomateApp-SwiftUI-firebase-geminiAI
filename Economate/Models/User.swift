//
//  User.swift
//  Economate
//
//  Created by Sualp Danacı on 23.05.2024.
//

import Foundation

//struct User {
//var userId: String
//var password: String
//
//}
//

struct User: Identifiable{
     
     let id: String
     let email: String
     let firstName: String
     let lastName: String
}

extension User {
     init?(from dictionary: [String: Any]) {
          guard
               let id = dictionary["uid"] as? String,
               let email = dictionary["email"] as? String,
               let firstName = dictionary["firstName"] as? String,
               let lastName = dictionary["lastName"] as? String
                    
          else {
               return nil
          }
          
          self.id = id
          self.email = email
          self.firstName = firstName
          self.lastName = lastName
     }
}
