//
//  GiftListScrollView.swift
//  SeeGiftNew
//
//  Created by Chris Rogers on 1/26/25.
//

import SwiftUI



struct UserGiftListView: View {
    @Environment(UserAccount.self) var currUser
    
    @State var showDescPopup = false
    @State var showList = true
    @State var currGift: Gift = Gift()
    @State var newList = testGiftList
    @State var createdUser: UserAccount = UserAccount()
    @State var currFavGiftIndex: Int = 0
    var body: some View {
        VStack{
            
            if (showDescPopup) {
                GiftDetailView(showList: $showList, showDescPopup: $showDescPopup, gift: $currGift, giftList: $newList, currFavGiftIndex: $currFavGiftIndex)
            }
            if (showList) {
                NavigationView {
                    ScrollView (showsIndicators: false) {
                        ForEach(newList) {gift in
                            Button(action: {
                                currGift = gift
                                currFavGiftIndex = newList.firstIndex(where: { $0.isMostWanted }) ?? 0
                                showDescPopup.toggle()
                                showList.toggle() //List and description popup should always be opposites
                            }) {
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
                            }.background(Color.yellow).foregroundStyle(.black).clipShape(RoundedRectangle(cornerRadius: 30))
                        }.listRowBackground(Color.black)
                        //Color.black.ignoresSafeArea(.all)
                        NavigationLink (destination: AddGiftView(createdUser)){
                            Label("Add New Gift", systemImage: "plus.app").font(.headline).imageScale(.large)
                        }.padding([.bottom])
                    }.padding()
                }
            }
        }//.background(Color.black).foregroundStyle(.white)
    }//.background(Color.black)
}

#Preview {
    UserGiftListView().environment(chris)
}
