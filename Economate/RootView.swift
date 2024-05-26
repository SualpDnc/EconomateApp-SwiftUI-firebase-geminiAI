//
//  RootView.swift
//  Economate
//
//  Created by Sualp Danacı on 26.05.2024.
//

import SwiftUI

struct RootView: View {
     
     @EnvironmentObject var appState: AppState
     
    var body: some View {
         switch appState.navigation{
         case .login:
              SignView()
                   .transition(.opacity)
         case .home:
              MainView()
                   .transition(.opacity)
         }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
