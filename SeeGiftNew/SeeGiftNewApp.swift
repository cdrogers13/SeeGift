//
//  SeeGiftNewApp.swift
//  SeeGiftNew
//
//  Created by Chris Rogers on 1/20/25.
//

import SwiftUI

@main
struct SeeGiftNewApp: App {
    //var currUser = UserAccount()
   @State var currUser = UserAccount()
//    init() {
//        
//
//            
//    }
    var body: some Scene {
        WindowGroup {
            HomeScreenView().environment(currUser)
            //LoginPage().accentColor(.yellow).preferredColorScheme(.dark)
        }
    }
}
