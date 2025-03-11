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
    @State var showAddGiftPopup: Bool = false
    @State var currGift: Gift = Gift()
    @State var newList = testGiftList
    @State var createdUser: UserAccount = UserAccount()
    @State var currFavGiftIndex: Int = 0
    let defaultGiftImage: Image = Image(systemName: "gift.fill")
    var body: some View {
        VStack{
            
            if (showDescPopup) {
                GiftDetailView(showList: $showList, showDescPopup: $showDescPopup, gift: $currGift, /*giftList: $currUser.giftsList, */currFavGiftIndex: $currFavGiftIndex)
            }
            if (showList) {
                NavigationView {
                    ZStack {
                        VStack {
                        ScrollView (showsIndicators: false) {
                            //                        ForEach(newList) {gift in
                            ForEach(currUser.giftsList) {gift in
                                Button(action: {
                                    currGift = gift
                                    currFavGiftIndex = currUser.giftsList.firstIndex(where: {
                                        /*currFavGiftIndex = newList.firstIndex(where: {*/ $0.isMostWanted }) ?? 0
                                    showDescPopup.toggle()
                                    showList.toggle() //List and description popup should always be opposites
                                }) {
                                    ZStack(alignment: .topTrailing) {
                                        HStack{
                                            if (gift.baseImage.isEmpty) {
                                                defaultGiftImage
                                            }
                                            else {
                                                Image(gift.baseImage).resizable().cornerRadius(50).scaledToFit().frame(width: 200, height: 200)
                                            }
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
                                }.allowsHitTesting(showAddGiftPopup ? false : true).background(Color.yellow).foregroundStyle(.black).clipShape(RoundedRectangle(cornerRadius: 30))
                            }.listRowBackground(Color.black)
                            //Color.black.ignoresSafeArea(.all)
                            //                        NavigationLink (destination: AddGiftView(createdUser)){
                            //                            NavigationLink (destination: AddGiftViaLinkView()){
                            //                                Label("Add New Gift", systemImage: "plus.app").font(.headline).imageScale(.large)
                            //                            }.padding([.bottom])
                            Button(action: {
                                showAddGiftPopup.toggle()
                            })
                            {
                                Label(showAddGiftPopup ? "Cancel" : "Add New Gift", systemImage: "plus.app").font(.headline).imageScale(.large)
                            }
                        }.padding().blur(radius: showAddGiftPopup ? 15 : 0).onTapGesture {
                            showAddGiftPopup = false
                        }
                            Button(action: {
                                
                            })
                            {
                                Image(systemName: "plus").resizable().frame(width: 50, height: 50).symbolVariant(.circle.fill).imageScale(.large)
//                                Label{ Text("New Gift").font(.headline) }
//                                icon: {Image(systemName: "plus").symbolVariant(.circle.fill).imageScale(.large)}.labelStyle(VerticalLabelStyle(textColor: .white, picColor: .yellow))
                            }
                    }
                        
                        //Let user select between adding a gift via link or manually when they click add gift
                        if (showAddGiftPopup) {
                            VStack {
                                HStack {
                                    NavigationLink (destination: AddGiftViaLinkView())
                                    {
                                        ZStack {
                                            RoundedRectangle(cornerRadius: 50).fill(.black).frame(width: 150, height: 150)
                                            Label("Add Gift Via Link", systemImage: "gift").foregroundStyle(.black).imageScale(.large).labelStyle(VerticalLabelStyle(textColor: .yellow, picColor: .yellow))
                                        }
                                    }//.background(.ultraThickMaterial)
                                    NavigationLink (destination: AddGiftView())
                                    {
                                        ZStack {
                                            RoundedRectangle(cornerRadius: 50).fill(.black).frame(width: 150, height: 150)
                                            Label("Add Gift Manually", systemImage: "gift").foregroundStyle(.black).imageScale(.large).labelStyle(VerticalLabelStyle(textColor: .yellow, picColor: .yellow))
                                        }
                                    }
                                }.padding()
                                Button("Cancel") {
                                    showAddGiftPopup.toggle();
                                }.padding([.top], 20).foregroundStyle(.black)
                            }
                        }
                    }
                    
                }
                
            }
        }//.background(Color.black).foregroundStyle(.white)
    }//.background(Color.black)
}

#Preview {
    UserGiftListView().environment(chris)
}
