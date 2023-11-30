//
//  REST.swift
//  SwiftNetworkRequestExamples
//
//  Created by YoungBin Lee on 11/29/23.
//

import Foundation
import SwiftUI

struct RESTView: View {
    let url: (String) -> URL = { symbol in
        URL(string: "https://api.binance.com/api/v3/ticker/price?symbol=\(symbol)")!
    }
    let urlSession = URLSession.shared
    
    var body: some View {
        VStack {
            Button(action: {
                Task { await request() }
            }) {
                Text("Request!")
            }
        }
        .padding()
    }
    
    private func request() async {
        var request = URLRequest(url: url("BTCUSDT"))
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let (url, response) = try await urlSession.download(for: request)
            
            if
                let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode != 200
            {
                print("HTTP Status Code: \(httpResponse.statusCode)")
                return
            }
            
            if let responseString = String(data: try Data(contentsOf: url), encoding: .utf8) {
                print("Response String: \(responseString)")
            }
        } catch {
            print(error)
        }
    }
}

#Preview {
    RESTView()
}

