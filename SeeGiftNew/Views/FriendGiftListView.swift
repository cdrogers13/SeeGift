//
//  GiftListScrollView.swift
//  SeeGiftNew
//
//  Created by Chris Rogers on 1/26/25.
//

import SwiftUI



struct FriendGiftListView: View {
    let testGift = Gift(name: "Test", price: 100.00, description: "This is a test gift", image: "Test")
    let testUserAccount = UserAccount(giftsList: testGiftList)
    var totalPrice: Double = 0
    @State var showDescPopup = false
    @State var showList = true
    @State var showCommentsModal = false
    @State var currGift: Gift = Gift()
    
    var body: some View {
        VStack{
            if (showDescPopup) {
                GiftDescriptionZoomView(showList: $showList, showDescPopup: $showDescPopup, gift: $currGift)
            }
            if (showList) {
                Section(header: Text("Viewing *INSERT USER HERE*'s Gift List")) {
                    Text("Total Cost Of All User Gifts: $\(String(format: "%.2f", testUserAccount.totalGiftValue))")
                        .font(.headline)
                }
                ScrollView (showsIndicators: false) {
                    ForEach(testGiftList, id: \.self) {gift in
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
            print("Test?")
        }) {
            VStack {
                
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
                    Text("#\(gift.ranking)").padding()
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
                print("Test?")
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
                        }
                        Text("#\(gift.ranking)").padding()
                    }
                }
            }.background(Color.yellow).foregroundStyle(.black).clipShape(RoundedRectangle(cornerRadius: 30))
    }
}



#Preview {
    FriendGiftListView()
}
