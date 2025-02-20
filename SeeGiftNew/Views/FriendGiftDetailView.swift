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
            Text(gift.name).font(.largeTitle)
            Button("Close") {
                showList.toggle() //List and description popup should always be opposites
                showDescPopup.toggle()
            }.buttonStyle(CloseButton()).padding([.bottom], 8)
            ZStack(alignment: .top) {
                Image(gift.image).resizable().scaledToFit().cornerRadius(120)
                
            }
            VStack(alignment: .leading){
                HStack{
                    if let url = URL(string: "\(gift.link)") {
                        Text("Purchasing Link: ")
                        Link(gift.link, destination: url)
                    }
                    //Text(gift.link)
                    
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
                //Text("Gift Description")
                Text(gift.description)
            }.padding(.top)
            
            //Text(gift.userComments)
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    FriendGiftDetailView(showList: .constant(true), showDescPopup: .constant(true), gift: .constant(testGiftList[0]))
}
