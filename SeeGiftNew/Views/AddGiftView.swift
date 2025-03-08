//
//  AddGiftView.swift
//  SeeGiftNew
//
//  Created by Chris Rogers on 1/26/25.
//

import SwiftUI

struct AddGiftView: View {
    @State var name: String = ""
    @State var price: Double = 0
    @State var link: String = ""
    @State var ranking: Int = 0
    @State var description: String = ""
    var giftID: Int = Int.random(in: 0...1000000000)
   
    private var user: UserAccount = UserAccount()
    init(_ user: UserAccount) {
        self.user = user
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Add Gifts To Account").font(.title).fontWeight(.bold).padding()
                Form {
                    HStack {
                        Text("Gift Name:")
                        TextField("Gift Name", text: $name).multilineTextAlignment(.trailing)
                    }
                    HStack {
                        Text("Gift Price:")
                        TextField("Price", value: $price, format: .currency(code: "USD")).multilineTextAlignment(.trailing)
                    }
                    HStack {
                        Text("URL Link:")
                        TextField("URL Link", text: $link).multilineTextAlignment(.trailing)
                    }
                    TextField("Item Description", text: $description).frame(height: 100, alignment: .top)
                    
                    
                }
                HStack{
                    Button("Save And Add New Gift") {
                        //This button will save the gift to the users giftlist (Want to add a nice little popup confirmation here)
                        userAddGift(user: user, giftName: name, giftPrice: price, giftDescription: description, giftLink: link, giftRanking: ranking)
//                        let newGift: Gift = Gift(name: name, price: price, description: description, link: link, ranking: ranking)
//                        user.giftsList.append(newGift)
                        //This button will essentially start the gift creation process over again. It's very crude right now by just erasing the data but that's kind of the idea
                        name = ""
                        price = 0
                        link = ""
                        ranking = 0
                        description = ""
                    }.buttonStyle(BorderedProminentButtonStyle()).foregroundStyle(.black)
                    
                    NavigationLink(destination: LoginPageView().navigationBarBackButtonHidden(true)) {
                        //TODO: Need to add a confirmation here to make sure user is done adding gifts
                        Text("Save And Finish")
                    }.buttonStyle(BorderedProminentButtonStyle()).foregroundStyle(.black)
                }.padding()
            }
        }
    }
}

#Preview {
    AddGiftView(UserAccount())
}
