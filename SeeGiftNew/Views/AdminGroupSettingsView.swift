//
//  AdminSettingsView.swift
//  SeeGiftNew
//
//  Created by Chris Rogers on 1/24/25.
//

import SwiftUI

struct AdminGroupSettingsView: View {
    @State var canSpouseMatch: Bool = false
    @State var canPreviousMatch: Bool = false
    @State var priceLimit: Double = 0
    var body: some View {
        NavigationView {
            VStack{
                Text("Edit Settings For Group *INSERT GROUP HERE*").font(.title).frame(height: 100, alignment: .top).padding()
                
                VStack {
                    //Need to add some help tooltip descriptions to these somehow
                    Toggle(isOn: $canSpouseMatch, label: {
                        Text("Can Spouses Match")
                    })
                    Toggle(isOn: $canPreviousMatch, label: {
                        Text("Can Previous Year Match")
                    })
                    //Put toggles and numbers in this HStack. Padding on the backside to give a nice gap to the gift pairings button
                    HStack(spacing: 130) {
                        Text("Group Price Limit")
                        TextField("Group Price Limit", value: $priceLimit, format: .currency(code: "USD")).multilineTextAlignment(.trailing)
                    }.padding([.bottom], 30)
                   // Show gift pairings if user is admin only
                    //NavigationLink(destination: Giftpairingsview){} TODO: I WANT THIS TO BE A POPUP, OR MODAL TYPE OF DISPLAY THAT JUST SHOWS A TABLE OR SOMETHING MAYBE?
                    Button("View Gift Pairings") {
                        //Modal could possibly be put in here as well instead of as a navigation
                    }.buttonStyle(BorderedProminentButtonStyle()).foregroundStyle(.black)
                }.frame(height: 300, alignment: .top)
                HStack {
                    Button("Save Settings") {
                        
                    }.buttonStyle(BorderedProminentButtonStyle()).foregroundStyle(.black)
                    Button("Cancel") {
                        
                    }.buttonStyle(BorderedProminentButtonStyle()).foregroundStyle(.black)
                }
            }
        }
        
        
        
    }
}

#Preview {
    AdminGroupSettingsView()
}
