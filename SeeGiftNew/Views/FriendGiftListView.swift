//
//  GiftListScrollView.swift
//  SeeGiftNew
//
//  Created by Chris Rogers on 1/26/25.
//

import SwiftUI



struct FriendGiftListView: View {
    var selectedFriend = UserAccount(giftsList: testGiftList)
    var totalPrice: Double = 0
    @State var showDescPopup = false
    @State var showList = true
    @State var showCommentsModal = false
    @State var currGift: Gift = Gift()
    
    var body: some View {
        VStack{
            if (showDescPopup) {
                FriendGiftDetailView(showList: $showList, showDescPopup: $showDescPopup, gift: $currGift)
            }
            if (showList) {
                Section(header: Text("Viewing \(selectedFriend.firstName)'s Gift List")) {}
                
                if (selectedFriend.giftsList.isEmpty) {
                    Image("Empty Gift List").resizable()
                    Text("\(selectedFriend.firstName)'s Gift List is Empty. Let them know they should fill it out!").multilineTextAlignment(.center)
                }
                else {
                    Text("Total Cost Of All User Gifts: $\(String(format: "%.2f", selectedFriend.totalGiftValue))")
                            .font(.headline)
                    ScrollView (showsIndicators: false) {
                        ForEach(selectedFriend.giftsList) {gift in
                            if(gift.isGifted) {
                                IsGiftedButton(showDescPopup: $showDescPopup, showList: $showList, currGift: $currGift, gift: gift)
                            }
                            else {
                                StandardGiftButton(showDescPopup: $showDescPopup, showList: $showList, currGift: $currGift, gift: gift)
                            }
                        }.listRowBackground(Color.black)
                        //Color.black.ignoresSafeArea(.all)
                    }.padding()
                }
            }
        }
    }
}


struct StandardGiftButton : View {
    @Binding var showDescPopup : Bool
    @Binding var showList : Bool
    @Binding var currGift: Gift
    var gift: Gift = Gift()
    
    var body: some View {
        Button(action: {
            currGift = gift
            showDescPopup.toggle()
            showList.toggle() //List and description popup should always be opposites
         }) {
            VStack {
                
                ZStack(alignment: .topTrailing) {
                    HStack{
                        Image(gift.image).resizable().cornerRadius(50).scaledToFit().frame(width: 200, height: 200)
                        Spacer()
                        VStack (alignment: .trailing){
                            Text(gift.name)
                            Text(gift.price, format: .currency(code: "USD"))
                            
                        }
                    }.padding()
                    if (gift.isMostWanted) {
                        Image(systemName: "star.fill").resizable().frame(width: 20, height: 20).padding()
                    }
                }
            }
        }.background(Color.yellow).foregroundStyle(.black).clipShape(RoundedRectangle(cornerRadius: 30))
    }
}

struct IsGiftedButton : View {
    @Binding var showDescPopup : Bool
    @Binding var showList : Bool
    @Binding var currGift: Gift
    var gift: Gift = Gift()
    
    var body: some View {
       
            Button(action: {
                currGift = gift
                showDescPopup.toggle()
                showList.toggle()
            }) {
                VStack (alignment: .center) {
                    Label("GIFTED!", systemImage: "gift.circle.fill").labelStyle(FlippedLabelStyle(textColor: .black, picColor: .green))
                    ZStack(alignment: .topTrailing) {
                        HStack{
                            Image(gift.image).resizable().cornerRadius(50).scaledToFit().frame(width: 200, height: 200).padding([.bottom])
                            Spacer()
                            VStack (alignment: .trailing){
                                Text(gift.name)
                                Text(gift.price, format: .currency(code: "USD"))
                            }.padding()
                        }.padding()
                        if (gift.isMostWanted) {
                            Image(systemName: "star.fill").resizable().frame(width: 20, height: 20).padding()
                        }
                    }
                }
            }.background(Color.yellow).foregroundStyle(.black).clipShape(RoundedRectangle(cornerRadius: 30))
    }
}



#Preview {
    FriendGiftListView()
}
