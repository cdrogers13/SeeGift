//
//  ContentView.swift
//  SeeGiftNew
//
//  Created by Chris Rogers on 1/20/25.
//

import SwiftUI

struct ContentView: View {
    @State private var value = 1
    var body: some View {
        
        NavigationView {
            VStack{
                TabView{
                    Text("HOME PAGE").tabItem({
                        Label("Home", systemImage: "house")
                    })
                    UserSettingsView().tabItem({
                        Label("Account", systemImage: "person.circle")
                    })
                    AdminGroupSettingsView().tabItem({
                        Label("Groups", systemImage: "person.3.fill")
                    })
                }
                ZStack {
                    Color.green
                    VStack (alignment: .leading) {
                        NavigationLink(destination: GenerateGifteeView())
                        {
                            Text("Get your giftee!")
                        }
                        NavigationLink(destination: SignUpPage())
                        {
                            Text("Create Account")
                        }
                        NavigationLink(destination: AdminGroupSettingsView())
                        {
                            Text("Group Settings")
                        }
                }
            }
            
            
            
                //GenerateGifteeView()
    //            SignUpPage()
    //            Image(systemName: "globe")
    //                .imageScale(.large)
    //                .foregroundStyle(.tint)
    //            Text("Hello, world!")
    //                .padding()
    //
    //            HStack (){
    //                Image("Test")
    //                    .resizable()
    //                    .scaledToFit()
    //                    .frame(width:100, height:100)
    //                Rectangle()
    //                    .fill(Color.blue)
    //             }
        
            }
            .padding()
        }
        
    }
}

#Preview {
    ContentView()
}
