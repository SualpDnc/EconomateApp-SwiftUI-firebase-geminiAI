//
//  DashboardView.swift
//  Economate
//
//  Created by Sualp Danacı on 28.04.2024.
//
import SwiftUI

struct DashboardView: View {
    
   
    var body: some View {
        VStack{
          
            Text("Your Dashboard")
                .bold()
                .font(.largeTitle)
                .foregroundColor(.teal)
                .padding(.top,20)
            
            MultiDatePicker(/*@START_MENU_TOKEN@*/"Label"/*@END_MENU_TOKEN@*/, selection: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Binding<Set<DateComponents>>@*/.constant([])/*@END_MENU_TOKEN@*/)
                .frame(width: 350, height: 100)
                .padding(.top,130)
        
            
            VStack{
               
                DetailRow(iconName: "turkishlirasign", label: "Profit", value: "376 tl")
                DetailRow(iconName: "turkishlirasign", label: "Loss", value: "0 tl")
                DetailRow(iconName: "trophy", label: "Best Option for that day", value: "Bim")
                DetailRow(iconName: "star.fill", label: "Most profitable product", value: "Nutella")
                DetailRow(iconName: "lightbulb.led", label: "Recommendation", value: "Pınar Sut")
                DetailRow(iconName: "eraser.fill", label: "Eraser", value: "Test")
            }
            .padding(.top,150)
            Spacer()
        }
        
    }
}
    
    
struct DashboardView_Previews: PreviewProvider {
        static var previews: some View {
            DashboardView()
        }
}

struct DetailRow: View {
    var iconName: String
    var label: String
    var value: String
    
    var body: some View {
        HStack {
            Image(systemName: iconName)
                .foregroundColor(.black)
                .frame(width: 30, height: 30)
            Text(label)
                .font(.body)
                .foregroundColor(.teal)
            Spacer()
            Text(value)
                .foregroundColor(.secondary)
                .font(.body)
            
        }
        .padding(.horizontal)
        
        
   
       
      
    }
}





