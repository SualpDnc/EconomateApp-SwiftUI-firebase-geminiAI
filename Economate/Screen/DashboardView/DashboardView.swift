//
//  DashboardView.swift
//  Economate
//
//  Created by Sualp Danacı on 28.04.2024.
//
import SwiftUI

struct DashboardView: View {
    
//    @State private var billHistory: BillHistory = BillHistory(totalBills: [
//        Bill(products: [
//            Product(productName: "ALTINORC TBIC 1 LLU", amount: "9.95", isLoss: false),
//            Product(productName: "INKILIG 1 L KEFIR", amount: "7.95", isLoss: false),
//            Product(productName: "AR 1 KG TARBYA", amount: "34.90", isLoss: false)
//        ]),
//        Bill(products: [
//            Product(productName: "KENTIRASKOPU30", amount: "15.90", isLoss: true),
//            Product(productName: "KG SUCUK 250G", amount: "51.95", isLoss: false),
//            Product(productName: "BG HOT DORITOS", amount: "15.95", isLoss: true)
//        ]),
//        Bill(products: [
//            Product(productName: "KLAMA KAB1 3 LU CO", amount: "9.95", isLoss: false),
//            Product(productName: "FST 1 25 L", amount: "42.95", isLoss: false),
//            Product(productName: "SACTI SALAM 75", amount: "23.50", isLoss: true)
//        ])
//    ])
    @StateObject private var viewModel = DashboardViewModel()
    
    var body: some View {
        NavigationView {
            if let billHistory = viewModel.billHistory {
                List {
                    ForEach(Array(billHistory.totalBills.enumerated()), id: \.element) { index, bill in
                        Section(header: Text("BILL \(index + 1)")) {
                            ForEach(bill.products) { product in
                                VStack(alignment: .leading) {
                                    Text(product.productName)
                                        .font(.headline)
                                    Text("$\(product.amount)")
                                        .font(.subheadline)
                                    Text(product.isLoss ? "Loss" : "No Loss")
                                        .font(.caption)
                                        .foregroundColor(product.isLoss ? .red : .green)
                                }
                            }
                        }
                    }
                }
                .navigationTitle("Bill History")
            } else {
                EmptyState(imageName: "empty-bills-placeholder", message: "You have no bills in your account.\n Please add a bill!")
            }
        }
        .onAppear{
            viewModel.getBillHistory()
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
    
}
