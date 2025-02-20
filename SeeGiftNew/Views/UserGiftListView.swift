//
//  GiftListScrollView.swift
//  SeeGiftNew
//
//  Created by Chris Rogers on 1/26/25.
//

import SwiftUI



struct UserGiftListView: View {
    //let testGift = Gift(name: "Test", price: 100.00, description: "This is a test gift", image: "Test")
    //let testUserAccount = UserAccount(giftsList: testGiftList)
    @State var showDescPopup = false
    @State var showList = true
    @State var currGift: Gift = Gift()
    @State var newList = testGiftList
    @State var createdUser: UserAccount = UserAccount()
    
    var body: some View {
        VStack{
            if (showDescPopup) {
                GiftDetailView(showList: $showList, showDescPopup: $showDescPopup, gift: $currGift)
            }
            if (showList) {
                NavigationView {
                    ScrollView (showsIndicators: false) {
                        ForEach(newList) {gift in
                            Button(action: {
                                currGift = gift
                                showDescPopup.toggle()
                                showList.toggle() //List and description popup should always be opposites
                                print("Test?")
                            }) {
                                ZStack(alignment: .topTrailing) {
                                    HStack{
                                        //                                Text("#\(gift.ranking)")
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
    UserGiftListView()
}
