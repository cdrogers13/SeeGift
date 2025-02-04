//
//  GiftListScrollView.swift
//  SeeGiftNew
//
//  Created by Chris Rogers on 1/26/25.
//

import SwiftUI

let testGift = Gift(name: "Test", price: 100.00, description: "This is a test gift", image: "Test")

struct GiftListScrollView: View {
    let testUserAccount = UserAccount(giftsList: testGiftList)
    var totalPrice: Double = 0
    @State var showPopUp = false
    
    var body: some View {
        ZStack{
            List {
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
                                //                                 Text(gift.description)
                                showPopUp.toggle()
                                print("Test?")
                            }, label: {
                                Text("See Description")
                            }).buttonStyle(BorderlessButtonStyle())
                            
                        }
                    }.frame(maxWidth: .infinity, alignment: .topLeading)
                    
                }
                if (showPopUp == true) {
                    //ADD A NEW VIEW HERE THAT WILL OVERRIDE THE ONE CURRENTLY SHOWN. WHAT I REALLY WANT IS A MODAL OF SOME KIND TO POPUP BUT MAYBE THAT WONT BE THE BEST
                    Text("HA-HA")
                }
                
                
                
                
                //             ForEach(pics, id: \.self) {element in
                //                                 HStack{
                //                     Image(element).resizable().scaledToFit().frame(width: 100, height: 100)
                //                     Text(element)
                //                 }
                
            }
            //            ForEach(elements, id: \.self) {element in
            //                Text(element)
            //            }
        }
            Section(footer: Text("More Information")) {
                Text("Contact us as (212) 555 3231")
            }
         
        
        Button(action: {
           
        }) {
            Label("Add New Gift", systemImage: "plus.app").font(.headline).imageScale(.large)
        }
    }
}

#Preview {
    GiftListScrollView()
}
