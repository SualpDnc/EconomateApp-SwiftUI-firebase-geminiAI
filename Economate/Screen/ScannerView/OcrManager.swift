//
//  OcrManager.swift
//  Economate
//
//  Created by Sualp Danacı on 31.05.2024.
//

import Foundation
import SwiftUI
import GoogleGenerativeAI
import FirebaseAuth

class OcrManager: ObservableObject {
    let model = GenerativeModel(name: "gemini-1.5-flash", apiKey: APIKey.default)
    @Published var ocrText: String = ""


    
    func imageProcess(image: UIImage) async {
        let prompt = "You are an OCR reader. Market receipts will be sent to you as pictures. Your task is to output the products written on the market receipts and the prices of these products as a JSON file, based on these grocery receipts. If you think the image is not clear enough, you can simply say The image is not clear enough. sample json:{Ürünler: / Ürün Adı: Naneli Sakız / Fiyat : 15"
        
        do {
            let response = try await model.generateContent(prompt, image)
            if let text = response.text {
                DispatchQueue.main.async {
                        print(text)
                        self.ocrText = text
                    self.fetchFromAPI()
                    //self.sendTextToAPI(text: self.ocrText)
                }
            }
        } catch {
            print("Error occurred while processing image: \(error)")
        }
    }
    
    
  /*  func sendTextToAPI(text: String) {
        guard let url = URL(string: "http://49.13.171.36:8010/upload_bill_mobile") else {
            print("Invalid URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        guard let uid = Auth.auth().currentUser?.uid else {
            print("User not logged in")
            return
        }
        guard let mail = Auth.auth().currentUser?.email else{
            print("Cannot find the email")
            return
        }
        
        let dict_bill: [String: Any] = [
                "user_uid": uid,
                "user_mail": mail,
                "products": text
            ]
        
            let jsonData = try? JSONSerialization.data(withJSONObject: dict_bill)

        request.httpBody = jsonData

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }

            if let responseJSON = try? JSONSerialization.jsonObject(with: data, options: []) {
                print("Response JSON: \(responseJSON)")
            }
        }

        task.resume()
    }*/
    
    
    func fetchFromAPI() {
        guard let url = URL(string: "http://49.13.171.36:8010/get_bill_history") else {
            print("Invalid URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        guard let uid = Auth.auth().currentUser?.uid else {
            print("User not logged in")
            return
        }
        guard let mail = Auth.auth().currentUser?.email else {
            print("Cannot find the email")
            return
        }

        let dict2: [String: Any] = [
            "user_mail": mail,
        ]

        guard let jsonData = try? JSONSerialization.data(withJSONObject: dict2) else {
            print("Error serializing JSON")
            return
        }

        request.httpBody = jsonData

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                return
            }

            guard let httpResponse = response as? HTTPURLResponse else {
                print("Invalid response")
                return
            }

            print("HTTP Status Code: \(httpResponse.statusCode)")

            guard let data = data else {
                print("No data received")
                return
            }

            do {
                if let responseJSON = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    print("Response JSON: \(responseJSON)")
                } else {
                    print("Unable to parse JSON response")
                }
            } catch {
                print("Error parsing JSON: \(error)")
            }
        }

        task.resume()
    }

}

