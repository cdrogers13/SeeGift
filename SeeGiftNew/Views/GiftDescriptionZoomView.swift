//
//  GiftDescriptionZoomView.swift
//  SeeGiftNew
//
//  Created by Chris Rogers on 2/8/25.
//

import SwiftUI


struct GiftDescriptionZoomView: View {
    private var gift: Gift
    init(_ gift: Gift) {
        self.gift = gift
    }
    let testGift = testGiftList[1]
    var body: some View {
        VStack{
            Text(gift.name).font(.largeTitle)
            Image(gift.image).resizable().scaledToFit().cornerRadius(120)
            VStack(alignment: .leading){
                HStack{
                    Text("Purchasing Link: ")
                    Text(gift.link)
                    
                }
                HStack{
                    Text("Gift Price: ")
                    Text(gift.price, format: .currency(code: "USD"))
                }
            }
            VStack{
                //Text("Gift Description")
                Text(gift.description)
            }.padding(.top)
            
            Text(gift.userComments)
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    GiftDescriptionZoomView(testGiftList[0])
}
