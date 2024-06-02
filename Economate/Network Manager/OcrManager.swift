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
        let prompt = """
You are an ocr converter.
Your task is to return the purchased products and the prices of those products as a json from the market receipt images you receive.
Send only the json structure as an answer, do not add anything other than that.

An example json format is as follows:

{
  "products":
          [
            {
              "Product Name": "Vivident Gum Storm",
              "Amount": 27.50
            },
            {
              "Product Name": "Ulker Choc. Be Happy C",
              "Amount": 30.00
            },
            {
              "Product Name": "Uludag Premium Cream",
              "Amount": 6.90
            },
            {
              "Product Name": "JJ Porcelain Ds Figure",
              "Amount": 55.90
            }
          ]
}

"""
        
        do {
            let response = try await model.generateContent(prompt, image)
            if let text = response.text {
                DispatchQueue.main.async {
                        print(text)
                        self.ocrText = text
                    self.sendTextToAPI(text: self.ocrText)
                    //self.sendTextToAPI(text: self.ocrText)
                }
            }
        } catch {
            print("Error occurred while processing image: \(error)")
        }
    }
    
    
    func sendTextToAPI(text: String) {
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
    }
    
    
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

