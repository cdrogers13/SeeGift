//
//  UserGroupsView.swift
//  SeeGiftNew
//
//  Created by Chris Rogers on 2/17/25.
//

import SwiftUI

struct UserGroupsView: View {
    //@State var userGroups: [UserGroup]
    var body: some View {
        NavigationView {
            ScrollView (showsIndicators: false) {
                ForEach(userGroupsArray) {group in
                    Button(action: {
                        
                    }) {
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
    UserGroupsView()
}
