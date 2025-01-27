//
//  CreateGroupView.swift
//  SeeGiftNew
//
//  Created by Chris Rogers on 1/26/25.
//

import SwiftUI



struct CreateGroupView: View {
    @State var groupName: String = ""
    //var groupAdmins: [UserAccount]
    //var members: [UserAccount]
    @State var groupType: String = ""//Family or Friend...probably use an enum here actually
    //var giftGivingCombos: [Int: [String: String]]
    //var settings: GroupSettings
    @State var currentYear: String = ""
    @State var showAlert: Bool = false
    @State var createdGroup: UserGroup = UserGroup(currentYear: 2025)
    //var availableGiftees: [UserAccount]
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Create New Gifting Group").font(.title).fontWeight(.bold).padding()
                Form {
                    HStack {
                        Text("Group Name:")
                        TextField("Group Name", text: $groupName).multilineTextAlignment(.trailing)
                    }
                    HStack {
                        Text("Group Type:")
                        //Picker
                    }
                    HStack {
                        Text("Gifting Year:")
                        TextField("Year", text: $currentYear).multilineTextAlignment(.trailing).keyboardType(.numberPad).onSubmit({
                            if (Int(currentYear) == nil) {
                                showAlert = true
                                currentYear = ""
                            }
                        })
                    }.alert(Text("Only Numbers Allowed In The Gifting Year Field"), isPresented: $showAlert) {
                        //Button("OK", role: .cancel) {}
                    }
                }
                NavigationLink(destination: ContentView()) {
                    Text("Save")
                }.buttonStyle(BorderedProminentButtonStyle())
            }
            
        }
    }
}

#Preview {
    CreateGroupView()
}
