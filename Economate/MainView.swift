//
//  MainView.swift
//  Economate
//
//  Created by Sualp Danacı on 28.04.2024.
//

import SwiftUI


struct MainView: View {
    
    let columns: [GridItem] = [GridItem(.flexible()),
                               GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationView {
            VStack(){
                Spacer()
                Image("economate-logo")
                    .resizable()
                    .frame(width: 170, height: 110)
                  
                Spacer()
                LazyVGrid(columns: columns){
                    
                    let extractedExpr: MainView.FrameworkTitleView = FrameworkTitleView(name: "Scanner", imageName: "barcode.viewfinder")
                    extractedExpr
                    FrameworkTitleView(name: "Wallet", imageName: "creditcard.circle")
                    FrameworkTitleView(name: "Receipts", imageName: "newspaper")
                    FrameworkTitleView(name: "Dashboard", imageName: "chart.bar.xaxis")
                    FrameworkTitleView(name: "Profile", imageName: "person")
                    FrameworkTitleView(name: "Settings", imageName: "gearshape")
                }
                .padding(.top,-20).padding(.horizontal,20)
                
                Spacer()
            }
        }
    }
    
struct MainView_Previews: PreviewProvider {
        static var previews: some View {
            MainView()
                .preferredColorScheme(.light)
            
        }
    }
    
    struct FrameworkTitleView: View {
        let name: String
        let imageName: String
        
        var body: some View {
            
            let destinationView: AnyView
            
            switch name {
                case "Profile":
                destinationView = AnyView(ProfileView())
                
                case "Scanner":
                destinationView = AnyView(ScannerView())
                
                case "Settings":
                destinationView = AnyView(SettingsView())
                
                case "Dashboard":
                destinationView = AnyView(DashboardView())
                
                default:
                    destinationView = AnyView(DashboardView())
            }
            
            return NavigationLink(
                destination: destinationView,
                label: {
                    VStack {
                        Image(systemName: imageName)
                            .resizable()
                            .frame(width: 50,height: 50)
                            .foregroundColor(Color.blue)
                        Text(name)
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(Color(.label))
                            .scaledToFit()
                            .minimumScaleFactor(0.6)
                    }
                    .padding(20)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.white, lineWidth: 0)
                            .frame(width: 160, height: 150)
                            .background(RoundedRectangle(cornerRadius: 30).fill(Color.teal).opacity(0.1))
                    )
                }
            ).padding()
        }
    }

}
