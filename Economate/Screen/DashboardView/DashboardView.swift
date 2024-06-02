//
//  DashboardView.swift
//  Economate
//
//  Created by Sualp Danacı on 28.04.2024.
//
import SwiftUI

struct DashboardView: View {
    
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
                                    Text(product.isLoss == "false" ? "Loss" : "No Loss")
                                        .font(.caption)
                                        .foregroundColor(product.isLoss == "false" ? .red : .green)
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
    
}
