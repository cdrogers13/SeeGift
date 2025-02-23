//
//  GiftDescriptionZoomView.swift
//  SeeGiftNew
//
//  Created by Chris Rogers on 2/8/25.
//

import SwiftUI


struct FriendGiftDetailView: View {
    @Binding var showList: Bool
    @Binding var showDescPopup: Bool
    @Binding var gift: Gift
    //@State var isGifted: Bool = false
    
    let testGift = testGiftList[1]
    var body: some View {
        VStack{
            Button("Close") {
                showList.toggle() //List and description popup should always be opposites
                showDescPopup.toggle()
            }.buttonStyle(CloseButton())//.padding([.bottom], 8)
            HStack {
                Text(gift.name).font(.largeTitle)
                if (gift.isMostWanted) {
                    Image(systemName: "star.fill").resizable().frame(width: 25, height: 25)
//                    Image(systemName: "star.fill").resizable().frame(width: 20, height: 20).padding()
                }
            }
            
            ZStack(alignment: .top) {
                Image(gift.image).resizable().scaledToFit().cornerRadius(120)
                
            }
            VStack(alignment: .leading){
                HStack{
                    if let url = URL(string: "\(gift.link)") {
                        Text("Purchasing Link: ")
                        Link(gift.link, destination: url)
                    }
                }
                HStack{
                    Text("Gift Price: ")
                    Text(gift.price, format: .currency(code: "USD"))
                }
                Toggle(isOn: $gift.isGifted, label: {
                    Text("Mark As Purchased?")
                }).toggleStyle(CheckboxToggleStyle())
            }
            VStack{
                Text(gift.description)
            }.padding(.top)
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    FriendGiftDetailView(showList: .constant(true), showDescPopup: .constant(true), gift: .constant(testGiftList[0]))
}
