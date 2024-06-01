//
//  OcrManager.swift
//  Economate
//
//  Created by Sualp Danacı on 31.05.2024.
//

import Foundation
import SwiftUI
import GoogleGenerativeAI

class OcrManager: ObservableObject {
    let model = GenerativeModel(name: "gemini-1.5-flash", apiKey: APIKey.default)
    @Published var ocrText: String = ""

    
    func imageProcess(image: UIImage) async {
        let prompt = ""
        
        do {
            let response = try await model.generateContent(prompt, image)
            if let text = response.text {
                DispatchQueue.main.async {
                        print(text)
                        self.ocrText = text
                }
            }
        } catch {
            print("Error occurred while processing image: \(error)")
        }
    }
}

