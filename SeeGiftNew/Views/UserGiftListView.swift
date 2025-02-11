//
//  GiftListScrollView.swift
//  SeeGiftNew
//
//  Created by Chris Rogers on 1/26/25.
//

import SwiftUI



struct UserGiftListView: View {
    let testGift = Gift(name: "Test", price: 100.00, description: "This is a test gift", image: "Test")
    let testUserAccount = UserAccount(giftsList: testGiftList)
    var totalPrice: Double = 0
    @State var showDescPopup = false
    @State var showList = true
    @State var showCommentsModal = false
    @State var currGift: Gift = Gift()
    
    var body: some View {
        ZStack{
            VStack{
                if (showDescPopup) {
                    //ADD A NEW VIEW HERE THAT WILL OVERRIDE THE ONE CURRENTLY SHOWN. WHAT I REALLY WANT IS A MODAL OF SOME KIND TO POPUP BUT MAYBE THAT WONT BE THE BEST
                    Button("Close") {
                        showList.toggle() //List and description popup should always be opposites
                        showDescPopup.toggle()
                    }
                    GiftDescriptionZoomView(currGift)
                }
                if (showList) {
                    ScrollView {
                        ForEach(testGiftList, id: \.self) {gift in
                            Button(action: {}) {
                                HStack{
                                    Image(gift.image).resizable().cornerRadius(50).scaledToFit().frame(width: 200, height: 200)
                                    Spacer()
                                    VStack (alignment: .trailing){
                                        Text(gift.name)
                                        Text(gift.price, format: .currency(code: "USD"))
                                        Button(action: {
                                            currGift = gift
                                            showDescPopup.toggle()
                                            showList.toggle() //List and description popup should always be opposites
                                            print("Test?")
                                        }, label: {
                                            Text("Details")
                                        }).buttonStyle(BorderlessButtonStyle())
                                    }
                                }.padding()
                            }.background(Color.yellow).foregroundStyle(.black).clipShape(RoundedRectangle(cornerRadius: 30))
                        }
                        //Color.black.ignoresSafeArea(.all)
                    }
                   
                }
        
                
                
                
//                ZStack{
//                    Color.yellow.opacity(0.25)
//                        .edgesIgnoringSafeArea(.all)
//                }
//                Section(header: Text("Viewing *INSERT USER HERE*'s Gift List")) {
//                    Text("Total Cost Of All User Gifts: $\(String(format: "%.2f", testUserAccount.totalGiftValue))")
//                        .font(.headline)
//                }
                
//                ScrollView {
//                    Button(action: {
//                        
//                    }) {
//                        Label("Add New Gift", systemImage: "plus.app").font(.headline).imageScale(.large)
//                    }
//                    //                if (showDescPopup) {
//                    //
//                    //                    //ADD A NEW VIEW HERE THAT WILL OVERRIDE THE ONE CURRENTLY SHOWN. WHAT I REALLY WANT IS A MODAL OF SOME KIND TO POPUP BUT MAYBE THAT WONT BE THE BEST
//                    //                    Button("Close") {
//                    //                        showDescPopup.toggle()
//                    //                    }
//                    //                    GiftDescriptionZoomView()
//                    //                }
//                    ForEach(testGiftList, id: \.self) {gift in
//                        
//                        HStack{
//                            Image(gift.image).resizable().cornerRadius(50).scaledToFit().frame(width: 200, height: 200)
//                            Spacer()
//                            VStack (alignment: .trailing){
//                                Text(gift.name)
//                                Text(gift.price, format: .currency(code: "USD"))
//                                Button(action: {
//                                    currGift = gift
//                                    showDescPopup.toggle()
//                                    showList.toggle() //List and description popup should always be opposites
//                                    print("Test?")
//                                }, label: {
//                                    Text("Details")
//                                }).buttonStyle(BorderlessButtonStyle())
//                                //                            Button(action: {
//                                //                                showCommentsModal.toggle()
//                                //                                print("Test?")
//                                //                            }, label: {
//                                //                                Text("User Comments")
//                                //                            }).buttonStyle(BorderlessButtonStyle())
//                                
//                            }
//                        }.frame(maxWidth: .infinity, alignment: .topLeading).background(Color.yellow)
//                        
//                    }
//                    //                         Section(footer: Text("More Information")) {
//                    //                             Text("Contact us as (212) 555 3231")
//                    //                         }
//                }.cornerRadius(50).background(Color.yellow.ignoresSafeArea()).foregroundStyle(.black)
                
            }.background(Color.black)
        }
    }
}

#Preview {
    UserGiftListView()
}
