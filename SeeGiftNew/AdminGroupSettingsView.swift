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
                Button("View Gift Pairings") {
                    
                }.buttonStyle(BorderedProminentButtonStyle())
            }.frame(height: 300, alignment: .top)
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
    AdminGroupSettingsView()
}
