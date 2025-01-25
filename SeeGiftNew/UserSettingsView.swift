//
//  AdminSettingsView.swift
//  SeeGiftNew
//
//  Created by Chris Rogers on 1/24/25.
//


//
//  AdminSettingsView.swift
//  SeeGiftNew
//
//  Created by Chris Rogers on 1/24/25.
//

import SwiftUI

struct UserSettingsView: View {
    @State var isUserPublic: Bool = false
    @State var isFriendsListPublic: Bool = false
    @State var priceLimit: Double = 0
    var body: some View {
        NavigationView {
            VStack{
                Text("User Settings").font(.title).frame(height: 100, alignment: .top).padding()
                
                VStack {
                    //Need to add some help tooltip descriptions to these somehow
                    
                    Text("View Gifts Lists")
                    Text("Friends")
                    Text("View Giftees")
                    Text("View Groups")
                    
                    //Put toggles and numbers in this HStack. Padding on the backside to give a nice gap to the gift pairings button
                    //            HStack(spacing: 130) {
                    //                Text("Group Price Limit")
                    //                TextField("Group Price Limit", value: $priceLimit, format: .currency(code: "USD")).multilineTextAlignment(.trailing)
                    //            }.padding([.bottom], 30)
                    //            Button("View Gift Pairings") {
                    //
                    //            }.buttonStyle(BorderedProminentButtonStyle())
                }.frame(height: 300, alignment: .top)
                
                NavigationLink(destination: GenerateGifteeView()) {
                    Text("Generate Giftee")
                }.buttonStyle(BorderedProminentButtonStyle())
            }
            HStack {
                Button("Save Settings") {
                    
                }.buttonStyle(BorderedProminentButtonStyle())
                Button("Cancel") {
                    
                }.buttonStyle(BorderedProminentButtonStyle())
            }
        }
        
    }
}

#Preview {
    UserSettingsView()
}
