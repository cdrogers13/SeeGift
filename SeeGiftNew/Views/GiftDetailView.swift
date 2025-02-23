//
//  GiftDescriptionZoomView.swift
//  SeeGiftNew
//
//  Created by Chris Rogers on 2/8/25.
//

import SwiftUI


struct GiftDetailView: View {
    @Binding var showList: Bool
    @Binding var showDescPopup: Bool
    @Binding var gift: Gift
    @Binding var giftList: [Gift]
    @Binding var currFavGiftIndex: Int
    var body: some View {
        
        
        VStack{
            Button("Close") {
                if (gift.isMostWanted && gift !== giftList[currFavGiftIndex]) {
                    giftList[currFavGiftIndex].isMostWanted = false
                }
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
                Toggle(isOn: $gift.isMostWanted, label: {
                    Text("Mark As Most Wanted")
                }).toggleStyle(FavoritedToggleStyle())
            }
            VStack{
                Text(gift.description)
            }.padding(.top)
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    GiftDetailView(showList: .constant(true), showDescPopup: .constant(true), gift: .constant(testGiftList[1]), giftList: .constant(testGiftList), currFavGiftIndex: .constant(0))
}
