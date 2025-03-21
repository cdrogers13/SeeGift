//
//  GiftDescriptionZoomView.swift
//  SeeGiftNew
//
//  Created by Chris Rogers on 2/8/25.
//

import SwiftUI


struct GiftDetailView: View {
    @Environment(UserAccount.self) var currUser
    @Binding var showList: Bool
    @Binding var showDescPopup: Bool
    @Binding var gift: Gift
    //@Binding var giftList: [Gift]
    @Binding var currFavGiftIndex: Int
    let defaultGiftImage: Image = Image(systemName: "gift.fill")
    var body: some View {
        
        
        VStack{
            Button("Close") {
                if (gift.isMostWanted && gift !== currUser.giftsList[currFavGiftIndex]) {
                    currUser.giftsList[currFavGiftIndex].isMostWanted = false
                }
                showList.toggle() //List and description popup should always be opposites
                showDescPopup.toggle()
                
            }.buttonStyle(CloseButton())//.padding([.bottom], 8)
            
//            }"Delete Gift", role: .destructive) {
//                print("NEEDS TO BE IMPLEMENTED")
////                if (gift.isMostWanted && gift !== currUser.giftsList[currFavGiftIndex]) {
////                    currUser.giftsList[currFavGiftIndex].isMostWanted = false
////                }
////                showList.toggle() //List and description popup should always be opposites
////                showDescPopup.toggle()
//                var currGiftIndex = currUser.giftsList.firstIndex(where: {$0.giftID == gift.giftID})
//                if let currGiftIndex = currGiftIndex {
//                    currUser.giftsList.remove(at: currGiftIndex)
//                }
//                else {
//                    print("Couldnt find gift. Found index was : \(currGiftIndex ?? -1), current gift id is : \(gift.giftID)")
//                }
               
//            }
            
            
            HStack {
                Text(gift.name).font(.largeTitle)
                if (gift.isMostWanted) {
                    Image(systemName: "star.fill").resizable().frame(width: 25, height: 25)
//                    Image(systemName: "star.fill").resizable().frame(width: 20, height: 20).padding()
                }
            }
            TabView() {
                if (gift.downloadedImages.isEmpty) {
                    defaultGiftImage.resizable().scaledToFit().cornerRadius(120)
                }
                else {
                    ForEach(gift.downloadedImages, id: \.self) { image in
                        Image(image).resizable().scaledToFit().cornerRadius(45)
                    }
                }
            }.tabViewStyle(PageTabViewStyle())
         
//                ScrollView(.horizontal) {
//                    HStack(spacing: 10) {
//                        ForEach(gift.downloadedImages, id: \.self) { image in
//                            Image(image)
//                                .resizable()
//                                .scaledToFit()
//                                .frame(width: max(120, UIScreen.main.bounds.width * 0.8),  // Minimum 120, scales up to 20% of screen width
//                                       height: max(120, UIScreen.main.bounds.width * 0.8)) // Keeps aspect ratio
//                                .cornerRadius(15)
//                        }
//                    }
//                }
                
//                Image(gift.image).resizable().scaledToFit().cornerRadius(120)
                
            //}.padding()
            
            VStack(alignment: .center){
                HStack{
                    if let url = URL(string: "\(gift.link)") {
                        //Text("Purchasing Link: ")
                        Link(gift.link, destination: url)
                    }
                    Text(gift.price, format: .currency(code: "USD"))
                }
                
                Toggle(isOn: $gift.isMostWanted, label: {
                    Text("Mark As Most Wanted")
                }).toggleStyle(FavoritedToggleStyle())
            }.padding(.bottom)
            VStack{
                Text(gift.description)
            }//.padding(.bottom)
            
        }//.frame(maxWidth: .infinity, maxHeight: .infinity)
        Button(action: {
            var currGiftIndex = currUser.giftsList.firstIndex(where: {$0.giftID == gift.giftID})
            if let currGiftIndex = currGiftIndex {
                currUser.giftsList.remove(at: currGiftIndex)
            }
            else {
                print("Couldnt find gift. Found index was : \(currGiftIndex ?? -1), current gift id is : \(gift.giftID)")
            }}) {
                Label("Delete Gift", systemImage: "trash").labelStyle(FlippedLabelStyle(textColor: .red, picColor: .red))
            }
    }
}

#Preview {
    GiftDetailView(showList: .constant(true), showDescPopup: .constant(true), gift: .constant(testGiftList[2]), /*currUser.giftsList: .constant(testGiftList),*/ currFavGiftIndex: .constant(0)).environment(chris)
}
