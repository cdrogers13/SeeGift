//
//  GiftDescriptionZoomView.swift
//  SeeGiftNew
//
//  Created by Chris Rogers on 2/8/25.
//

import SwiftUI


struct GiftDescriptionZoomView: View {
    let testGift = testGiftList[0]
    var body: some View {
        Text(testGift.name).font(.largeTitle)
        Image(testGift.image).resizable().scaledToFit().cornerRadius(120)
        Text(testGift.description)
    }
}

#Preview {
    GiftDescriptionZoomView()
}
