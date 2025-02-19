//
//  GroupDetailView.swift
//  SeeGiftNew
//
//  Created by Chris Rogers on 2/18/25.
//

import SwiftUI

struct GroupDetailView: View {
    @State var activeGroup: UserGroup = x24
    var body: some View {
       
        //If viewing user is an admin of the group then put the setting cog in the top right
        
        //Header Text of some sort with the group name here
        Text("\(activeGroup.groupName)").font(.title).fontDesign(.serif)
        NavigationView {
            List {
                ForEach(activeGroup.members) {member in
                    NavigationLink(destination: FriendGiftListView(selectedFriend: member)) {
                        HStack{
                            VStack {
                                //Put users profile pic above their name
                                Image(member.profilePicture).resizable().scaledToFit().padding()
                                Text(member.firstName)
                            }
                            Text("View Gift List")
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    GroupDetailView()
}
