//
//  LoginPage.swift
//  SeeGiftNew
//
//  Created by Chris Rogers on 1/29/25.
//

import SwiftUI

struct LoginPage: View {
    @State var username: String = ""
    @State var password: String = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                Label ("GiftBee", systemImage: "gift").font(.largeTitle).padding()
                VStack {
                    Form {
                        HStack {
                            Text("Username:")
                            TextField("Username", text: $username)
                        }
                        HStack {
                            Text("Password:")
                            SecureField("Password", text: $password)
                        }
                    }.frame(maxHeight: 400)
                    Button ("Sign In") {
                        //TODO: This is probably gonna need to be a navigationlink but i need to add the code to validate the sign-in
                    }.buttonStyle(BorderedProminentButtonStyle())
                }
                VStack {
                    NavigationLink(destination: SignUpPage()){
                        Text("New User? Sign Up Here!")
                    }
                }
            }
        }
    }
}

#Preview {
    LoginPage()
}
