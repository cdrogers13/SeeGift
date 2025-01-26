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
                    HStack {
                        Text("Gift Ranking:")
                        TextField("Gift Ranking", value: $ranking, format: .number).multilineTextAlignment(.trailing)
                    }
                    TextField("Item Description", text: $description).frame(height: 100, alignment: .top)
                }
                NavigationLink(destination: ContentView()) {
                    Text("Save")
                }.buttonStyle(BorderedProminentButtonStyle())
            }
        }
    }
}

#Preview {
    AddGiftView(UserAccount())
}
