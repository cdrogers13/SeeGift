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
        NavigationStack {
            VStack {
                VStack{
//                    Text("User Settings").font(.title).frame(height: 100, alignment: .top).padding()
                    
                    VStack {
                        //Need to add some help tooltip descriptions to these somehow
                        List {
                            Text("View Gifts Lists")
                            Text("Friends")
                            Text("View Giftees")
                            Text("View Groups")
                        }
                        
                        
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
                    }.padding().buttonStyle(BorderedProminentButtonStyle()).padding()
                }
                HStack {
                    Button("Save Settings") {
                        
                    }.buttonStyle(BorderedProminentButtonStyle())
                    Button("Cancel") {
                        
                    }.buttonStyle(BorderedProminentButtonStyle())
                }.navigationTitle(Text("User Settings")).toolbar {//the toolbar is the gear at the top right in this case
                    //the navigation title is what shows up at the top of a screen when it's navigated to I guess?
                    
                    ToolbarItem {
                        Text("HI?")
                        
                    }
                    ToolbarItem {
                        Image(systemName: "gearshape.fill")
                    }
                    ToolbarItem {
                        Image(systemName: "gearshape.fill")
                    }
                    ToolbarItem (placement: .navigationBarLeading) {
                        Image(systemName: "gearshape.fill")
                    }
                }
            }
            }
        
    }
}

#Preview {
    UserSettingsView()
}
