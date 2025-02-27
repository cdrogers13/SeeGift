//
//  UserGroupsView.swift
//  SeeGiftNew
//
//  Created by Chris Rogers on 2/17/25.
//

import SwiftUI

struct UserGroupsListView: View {
    var body: some View {
        NavigationView {
            ScrollView (showsIndicators: false) {
                ForEach(userGroupsArray) {group in
                    NavigationLink(destination: GroupDetailView(activeGroup: group)) {
                        
                            ZStack{
                                RoundedRectangle(cornerRadius: 60, style: .continuous).frame(width: 350, height: 300)
                                Text(group.groupName).font(.headline).foregroundColor(.black)
                            }
                        }.background(.black).foregroundStyle(.yellow).clipShape(RoundedRectangle(cornerRadius: 30))
                    
                }.listRowBackground(Color.black)
            }.padding()
        }
    }
}

#Preview {
    UserGroupsListView()
}
