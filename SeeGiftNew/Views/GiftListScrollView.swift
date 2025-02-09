//
//  GiftListScrollView.swift
//  SeeGiftNew
//
//  Created by Chris Rogers on 1/26/25.
//

import SwiftUI



struct GiftListScrollView: View {
    let testGift = Gift(name: "Test", price: 100.00, description: "This is a test gift", image: "Test")
    let testUserAccount = UserAccount(giftsList: testGiftList)
    var totalPrice: Double = 0
    @State var showDescPopup = false
    @State var showList = true
    @State var showCommentsModal = false
    @State var currGift: Gift = Gift()
    
    var body: some View {
        if (showDescPopup) {
            //ADD A NEW VIEW HERE THAT WILL OVERRIDE THE ONE CURRENTLY SHOWN. WHAT I REALLY WANT IS A MODAL OF SOME KIND TO POPUP BUT MAYBE THAT WONT BE THE BEST
            Button("Close") {
                showList.toggle() //List and description popup should always be opposites
                showDescPopup.toggle()
            }
            GiftDescriptionZoomView(currGift)
        }
        if (showList) {
            List {
     //                if (showDescPopup) {
     //
     //                    //ADD A NEW VIEW HERE THAT WILL OVERRIDE THE ONE CURRENTLY SHOWN. WHAT I REALLY WANT IS A MODAL OF SOME KIND TO POPUP BUT MAYBE THAT WONT BE THE BEST
     //                    Button("Close") {
     //                        showDescPopup.toggle()
     //                    }
     //                    GiftDescriptionZoomView()
     //                }
                     Section(header: Text("Important Information")) {
                         Text("Total Cost Of All User Gifts: $\(String(format: "%.2f", testUserAccount.totalGiftValue))")
                             .font(.headline)
                     }
                     ForEach(testGiftList, id: \.self) {gift in
                         
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
     //                            Button(action: {
     //                                showCommentsModal.toggle()
     //                                print("Test?")
     //                            }, label: {
     //                                Text("User Comments")
     //                            }).buttonStyle(BorderlessButtonStyle())
                                 
                             }
                         }.frame(maxWidth: .infinity, alignment: .topLeading)
                         
                     }
                     Section(footer: Text("More Information")) {
                         Text("Contact us as (212) 555 3231")
                     }
                  }
             Button(action: {
                
             }) {
                 Label("Add New Gift", systemImage: "plus.app").font(.headline).imageScale(.large)
             }
        }
       
    }
}

#Preview {
    GiftListScrollView()
}
