//
//  WebsocketVIew.swift
//  SwiftNetworkRequestExamples
//
//  Created by ab180 on 11/30/23.
//

import Foundation
import SwiftUI

struct WebsocketView: View {
    let task = URLSession.shared.webSocketTask(
        with: URL(string: "wss://stream.binance.com:9443/ws/btcusdt@trade")!
    )
    
    @State var reactionCount = 0
    
    var body: some View {
        Button(action: { Task { await sendMessage() } }) {
            Text("Button")
        }
        .task {
            await startTask()
        }
        .onDisappear {
            task.cancel()
        }
    }
    
    func sendMessage() async {
        print("Message sent")
        do {
            try await task.send(.string("BTC"))
        } catch {
            print("Error in sending message: \(error)")
        }
    }
    
    func startTask() async {
        print("Trying to connect websocket")
        task.resume()  // Ensure the task is resumed
        await receiveMessage()
    }
    
    func receiveMessage() async {
        do {
            let message = try await task.receive()
            print("Received message: \(message)")
            await self.receiveMessage()  // Recursive call to continue receiving messages
        } catch {
            print("Error in receiving message: \(error)")
        }
    }
}

#Preview {
    WebsocketView()
}

