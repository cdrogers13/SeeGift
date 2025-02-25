//
//  ContentView.swift
//  SeeGiftNew
//
//  Created by Chris Rogers on 1/20/25.
//

import SwiftUI

struct HomeScreenView: View {
    @State private var value = 1
    var body: some View {
        VStack{
            Section (header: Label {Text("GiftBee")}
                     icon: {
                Image(systemName: "gift").foregroundStyle(.yellow)
                     }) {}.font(.largeTitle)
            //Text("HOME PAGE")
//            TabView{
//                Group {
//                    UserGiftListView().tabItem({
//                        Label("Home", systemImage: "house")
//                    })
//                    FriendGiftListView().tabItem({
//                        Label("Account", systemImage: "person.circle")
//                    })
//                    AdminGroupSettingsView().tabItem({
//                        Label("Groups", systemImage: "person.3.fill")
//                    })
//                }.toolbarBackground(.visible, for: .tabBar).toolbarBackground(.black, for: .tabBar)
//            }
            
            
            
            AddGiftViaLinkView()
    //                NavigationView {
    //
    //                ZStack {
    //                    navigationTitle(Text("SeeGift"))
    //                    Color.green
    //                    VStack (alignment: .leading) {
    //                        NavigationLink(destination: GenerateGifteeView())
    //                        {
    //                            Text("Get your giftee!")
    //                        }
    //                        NavigationLink(destination: SignUpPage())
    //                        {
    //                            Text("Create Account")
    //                        }
    //                        NavigationLink(destination: AdminGroupSettingsView())
    //                        {
    //                            Text("Group Settings")
    //                        }
    //                    }
    //                }
    //
    //
    //
    //                //GenerateGifteeView()
    //    //            SignUpPage()
    //    //            Image(systemName: "globe")
    //    //                .imageScale(.large)
    //    //                .foregroundStyle(.tint)
    //    //            Text("Hello, world!")
    //    //                .padding()
    //    //
    //    //            HStack (){
    //    //                Image("Test")
    //    //                    .resizable()
    //    //                    .scaledToFit()
    //    //                    .frame(width:100, height:100)
    //    //                Rectangle()
    //    //                    .fill(Color.blue)
    //    //             }
    //
    //            }
    //            .padding()
        }.accentColor(.yellow).preferredColorScheme(.dark)
    }
}

#Preview {
    HomeScreenView()
}
