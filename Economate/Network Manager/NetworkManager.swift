//
//  NetworkManager.swift
//  Economate
//
//  Created by Sualp Danacı on 26.05.2024.
//

import Foundation

protocol NetworkManagerProtocol: ObservableObject{
     func signIn(withEmail email: String,password: String) async throws
     
     func signOut()
}

