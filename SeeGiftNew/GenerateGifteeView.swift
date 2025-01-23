//
//  SwiftUIView.swift
//  SeeGiftNew
//
//  Created by Chris Rogers on 1/22/25.
//

import SwiftUI

struct GenerateGifteeView: View {
    var body: some View {
        VStack(spacing: 75) {
            Text("PUT THE GROUP NAME IN BIG LETTERS UP HERE MAYBE?")
            
            Button(action: { print("HI") })
            {
                ZStack {
                    Circle().frame(width: 350, height: 350).background(Color.blue).cornerRadius(360)
                    Label("Generate Your Giftee!", systemImage: "gift").foregroundStyle(.white)
                }
            }
        }
        .padding()
    }
}
#Preview {
    GenerateGifteeView()
}
