//
//  EmptyView.swift
//  Economate
//
//  Created by Sualp Danacı on 2.06.2024.
//

import SwiftUI

struct EmptyState: View {
    
    let imageName: String
    let message: String
    
    var body: some View {
        ZStack {
            Color(.systemBackground)
                .ignoresSafeArea()
            
            VStack {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 160)
                    .padding()
                
                Text(message)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.secondary)
                    
            }
            .offset(y: -64)
        }
        
    }
}
struct EmptyView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
    }
}
