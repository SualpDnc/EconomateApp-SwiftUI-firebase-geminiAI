//
//  MainView.swift
//  Economate
//
//  Created by Sualp Danacı on 28.04.2024.
//

import SwiftUI


struct MainView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    let columns: [GridItem] = [GridItem(.flexible())
                            
    ]
    
    var body: some View {
        NavigationView {
            VStack(){
               
                Image("economate-logo")
                    .resizable()
                    .frame(width: 170, height: 110)
                    .padding(.top,60)
                  
                Spacer()
                LazyVGrid(columns: columns){
                    
                    let extractedExpr: MainView.FrameworkTitleView = FrameworkTitleView(name: "Scanner", imageName: "barcode.viewfinder")
                    extractedExpr
                    //FrameworkTitleView(name: "Wallet", imageName: "creditcard.circle")
                    FrameworkTitleView(name: "Receipts", imageName: "newspaper")
                    //FrameworkTitleView(name: "Dashboard", imageName: "chart.bar.xaxis")
                    //FrameworkTitleView(name: "Profile", imageName: "person")
                    FrameworkTitleView(name: "Settings", imageName: "gearshape")
                }
               
                
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
                    .padding(15)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.white, lineWidth: 0)
                            .frame(width: 260, height: 123)
                            .background(RoundedRectangle(cornerRadius: 20).fill(Color.teal).opacity(0.1))
                    )
                }
            ).padding()
        }
    }

}
