//
//  ContentView.swift
//  SeeGiftNew
//
//  Created by Chris Rogers on 1/20/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            SignUpPage()
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
