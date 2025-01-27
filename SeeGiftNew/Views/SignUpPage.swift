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
    @State var createdUser: UserAccount = UserAccount()
    
    var body: some View {
        NavigationView {
            VStack{
                Form {
                    TextField("First Name", text: $firstName).onChange(of: firstName) { print(firstName)
                    }
                    TextField("Last Name", text: $lastName)
                    TextField("Email", text: $email)
                    TextField("UserName", text: $userName)
                    TextField("Spouse", text: $spouse)
                    SecureField("Password", text: $password)
                    }
                NavigationLink(destination: AddGiftView(createdUser)) {
                        Text("Save")
                    }.buttonStyle(BorderedProminentButtonStyle())
            }
        }
    }
}

#Preview {
    SignUpPage()
}
