//
//  ProfileViewModel.swift
//  Economate
//
//  Created by Sualp Danacı on 29.05.2024.
//

import Foundation

class ProfileViewModel: ObservableObject {
    
    @Published var user: User?
    
    func fetchUser() {
        FirebaseManager.shared.fetchUser { user in
            guard let user = user else { return }
            self.user = user
        }
    }
}
