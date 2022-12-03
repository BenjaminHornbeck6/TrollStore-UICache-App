//
//  ContentView.swift
//  TrollStore-UICache
//
//  Created by Hornbeck on 12/2/22.
//

import SwiftUI

struct ContentView: View {
    @State var RunningUICache = false
    @State var TimeRemaining = 32 //Takes 32 seconds for my iPhone 6s Plus on iOS 14.3
    var body: some View {
        if RunningUICache {
            Text("Running UICache \(TimeRemaining)s Left")
            ProgressView(value: 100 - Double(TimeRemaining * 100 / 32), total: 100)
                .padding(.horizontal, 75)
                .onReceive(Timer.publish(every: 1, on: .main, in: .common).autoconnect()) { time in
                    if TimeRemaining > 0 {
                        TimeRemaining -= 1
                    }
                }
        }
        Button {
            DispatchQueue.global(qos: .utility).async {
                RunningUICache = true
                spawnRoot("\(SBFApplication(applicationBundleIdentifier: "com.opa334.TrollStore").bundleURL.path)/trollstorehelper", ["refresh-all"])
               RunningUICache = false
            }
        } label: {
            Text("Run UICache")
        }
        .disabled(RunningUICache)
    }
}
