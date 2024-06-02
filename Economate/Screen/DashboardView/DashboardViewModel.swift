//
//  DashboardViewModel.swift
//  Economate
//
//  Created by Sualp Danacı on 2.06.2024.
//

import Foundation

class DashboardViewModel: ObservableObject {
    
    @Published var billHistory: BillHistory?
    
    
    func getBillHistory() {
        let jsonString = """
        {
            "totalBills": [
                {
                    "products": [
                        {
                            "Product Name": "ALTINORC TBIC 1 LLU",
                            "Amount": "9.95",
                            "IsLoss": false
                        },
                        {
                            "Product Name": "INKILIG 1 L KEFIR",
                            "Amount": "7.95",
                            "IsLoss": false
                        },
                        {
                            "Product Name": "AR 1 KG TARBYA",
                            "Amount": "34.90",
                            "IsLoss": false
                        }
                    ]
                },
                {
                    "products": [
                        {
                            "Product Name": "KENTIRASKOPU30",
                            "Amount": "15.90",
                            "IsLoss": true
                        },
                        {
                            "Product Name": "KG SUCUK 250G",
                            "Amount": "51.95",
                            "IsLoss": false
                        },
                        {
                            "Product Name": "BG HOT DORITOS",
                            "Amount": "15.95",
                            "IsLoss": true
                        },
                        {
                            "Product Name": "MİGROS 2L AYRAN",
                            "Amount": "10.50",
                            "IsLoss": false
                        },
                        {
                            "Product Name": "ÜLKER ÇİKOLATA",
                            "Amount": "7.75",
                            "IsLoss": true
                        }
                    ]
                },
                {
                    "products": [
                        {
                            "Product Name": "KLAMA KAB1 3 LU CO",
                            "Amount": "9.95",
                            "IsLoss": false
                        },
                        {
                            "Product Name": "FST 1 25 L",
                            "Amount": "42.95",
                            "IsLoss": false
                        },
                        {
                            "Product Name": "SACTI SALAM 75",
                            "Amount": "23.50",
                            "IsLoss": true
                        },
                        {
                            "Product Name": "TURKCELL TL YÜKLEME",
                            "Amount": "20.00",
                            "IsLoss": false
                        }
                    ]
                },
                {
                    "products": [
                        {
                            "Product Name": "UNO EKMEK",
                            "Amount": "4.50",
                            "IsLoss": false
                        },
                        {
                            "Product Name": "COKE 1L",
                            "Amount": "5.95",
                            "IsLoss": true
                        },
                        {
                            "Product Name": "NESTLE 250G KAHVE",
                            "Amount": "28.90",
                            "IsLoss": false
                        },
                        {
                            "Product Name": "PRİL 1L DETERJAN",
                            "Amount": "18.50",
                            "IsLoss": false
                        },
                        {
                            "Product Name": "LAV 6LI BARDAK",
                            "Amount": "24.75",
                            "IsLoss": false
                        }
                    ]
                },
                {
                    "products": [
                        {
                            "Product Name": "YUDUM 1L YAĞ",
                            "Amount": "26.95",
                            "IsLoss": true
                        },
                        {
                            "Product Name": "DİMES 1L MEYVE SUYU",
                            "Amount": "12.75",
                            "IsLoss": false
                        },
                        {
                            "Product Name": "PIRLANTA 1KG PİRİNÇ",
                            "Amount": "18.95",
                            "IsLoss": false
                        }
                    ]
                }
            ]
        }
        """

        let jsonData = Data(jsonString.utf8)
        
        do {
            let decoder = JSONDecoder()
            let response = try decoder.decode(BillHistory.self, from: jsonData)
            DispatchQueue.main.async {
                self.billHistory = response
//                self.isLoading = false
            }
        } catch {
            DispatchQueue.main.async {
                print("Error")
//                self.errorMessage = error.localizedDescription
//                self.isLoading = false
            }
        }
    }
    
    
}

