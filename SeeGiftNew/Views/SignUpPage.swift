//
//  SignUpPage.swift
//  SeeGiftNew
//
//  Created by Chris Rogers on 1/20/25.
//

import SwiftUI

struct SignUpPage: View {
    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var userName: String = ""
    @State var password: String = ""
    @State var email: String = ""
    @State var spouse: String = ""
    @State var showSpouse: Bool = false
    @State var createdUser: UserAccount = UserAccount()
    
    var body: some View {
        NavigationView {
            VStack{
                Text("Welcome to GiftBee!").font(.title).fontWeight(.bold)
                Text("Enter Your Information Below To Create An Account")
                Form {
                    HStack{
                        Text("First Name")
                        TextField("First Name", text: $firstName).onChange(of: firstName) { print(firstName)
                    }
                    
                    }
                    HStack{
                        Text("Last Name")
                        TextField("Last Name", text: $lastName)
                    }
                    
                    HStack{
                        Text("E-Mail")
                        TextField("Email", text: $email)
                    }
                    
                    HStack{
                        Text("UserName")
                        TextField("UserName", text: $userName)
                    }
                    
                    HStack{
                        //TODO: This should be optional. Ask user if they have a spouse with a GiftBee account that they would like to link. Then probably do a search of some kind to make sure the spouse exists and link the name that way
                        Text("Spouse UserName")
                        TextField("Spouse", text: $spouse)
                    }
                    
                    HStack{
                        Text("Password")
                        SecureField("Password", text: $password)
                    }
                    
                    }
                NavigationLink(destination: AddGiftView(createdUser)) {
                        Text("Create Account")
                    //This image works as a button too, so i can make something cool like this link: https://www.reddit.com/r/SwiftUI/comments/od2uum/is_there_a_preview_bug_where_navigation_links/
                    
                    //Dope as ass
//                    Image("Test").resizable().aspectRatio(contentMode: .fit).cornerRadius(120)
                }.buttonStyle(BorderedProminentButtonStyle())
            }
        }
    }
}

#Preview {
    SignUpPage()
}
