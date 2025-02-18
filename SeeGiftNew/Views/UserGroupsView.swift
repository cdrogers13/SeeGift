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
                        ZStack(alignment: .topTrailing) {
                            HStack{
                                //                                Text("#\(gift.ranking)")
//                                Image(group.groupImage).resizable().cornerRadius(50).scaledToFit().frame(width: 200, height: 200)
                                Spacer()
                                VStack (alignment: .trailing){
                                    Text(group.groupName)
//                                    Text(gift.price, format: .currency(code: "USD"))
                                    //                                    Button(action: {
                                    //                                        currGift = gift
                                    //                                        showDescPopup.toggle()
                                    //                                        showList.toggle() //List and description popup should always be opposites
                                    //                                        print("Test?")
                                    //                                    }, label: {
                                    //                                        Text("Details")
                                    //                                    }).buttonStyle(BorderlessButtonStyle())
                                }
                            }.padding()
                            //Text("#\(gift.ranking)").padding()
                        }
                        
                    }.background(Color.yellow).foregroundStyle(.black).clipShape(RoundedRectangle(cornerRadius: 30))
                }.listRowBackground(Color.black)
                //Color.black.ignoresSafeArea(.all)
//                NavigationLink (destination: AddGiftView(createdUser)){
//                    Label("Add New Gift", systemImage: "plus.app").font(.headline).imageScale(.large)
//                }.padding([.bottom])
            }.padding()
        }
    }
}

#Preview {
    UserGroupsView()
}
