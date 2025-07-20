//
//  GeminiAPI.swift
//  Cuan Girls
//
//  Created by Regina Celine Adiwinata on 20/07/25.
//

import Foundation

enum APIKey {
    static var `default`: String {
        guard let filePath = Bundle.main.path(forResource: "GenerativeAI-Info", ofType: "plist") else {
            fatalError("Tidak terhubung ke Gemini API")
        }
        let plist = NSDictionary(contentsOfFile: filePath)
        guard let value = plist?["API_KEY"] as? String else {
            fatalError( "Tidak terhubung ke Gemini API")
        }
        if value.starts(with: "_") {
            fatalError("Tidak terhubung ke Gemini API")
        }
        
        return value
    }
}
