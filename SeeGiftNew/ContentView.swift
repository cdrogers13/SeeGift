//
//  ContentView.swift
//  SeeGiftNew
//
//  Created by Chris Rogers on 1/20/25.
//

import SwiftUI

struct ContentView: View {
    @State private var value = 1
    var body: some View {
        VStack (alignment: .leading) {
//            SignUpPage()
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
                .padding()
                
            HStack (){
                Image("Test")
                    .resizable()
                    .scaledToFit()
                    .frame(width:100, height:100)
                Rectangle()
                    .fill(Color.blue)
             }
    
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
