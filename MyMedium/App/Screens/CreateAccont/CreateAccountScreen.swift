//
//  CreateAccountScreen.swift
//  MyMedium
//
//  Created by neosoft on 10/01/23.
//

import SwiftUI

struct CreateAccountScreen: View {
    @State var screnType: LoginScreenType = LoginScreenType(title: "Login Screen", isCreateAccount: false)
    
    @State private var emailText: String = ""
    @State private var isValidEmail: Bool = false
    
    var body: some View {
        VStack (spacing: 14) {
            AppInputBox(    
                               leftIcon:"heart.text.square",
                               rightIcon: isValidEmail ? "checkmark.circle.fill" : "x.circle",
                               placeHoldr: "Email",
                               view: TextField("Email", text: $emailText),
                               keyboard: AppKeyBoardType.emailAddress,
                               state: isValidEmail
                           )
                           .onChange(of: emailText) { newValue in
                               let result = Helpers.isVaildEmailRegx(text: emailText)
                               withAnimation {
                                   isValidEmail = result
                                   print(isValidEmail)
                               }
                           }
            Text("Login")
        }
        .navigationTitle(screnType.title)
    }
}

struct CreateAccountScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CreateAccountScreen()
        }
    }
}
