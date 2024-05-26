//
//  AppState.swift
//  Economate
//
//  Created by Sualp Danacı on 26.05.2024.
//

import SwiftUI

final class AppState: ObservableObject {
    enum Navigation {
        case login, home
    }

    @Published var navigation: Navigation = .login
    static let shared = AppState()

    private init() {}
}


