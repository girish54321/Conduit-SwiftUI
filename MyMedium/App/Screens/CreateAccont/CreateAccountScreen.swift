//
//  CreateAccountScreen.swift
//  MyMedium
//
//  Created by neosoft on 10/01/23.
//

import SwiftUI

struct CreateAccountScreen: View {
    @State var screnType: LoginScreenType = LoginScreenType(title: "Login", isCreateAccount: false)
    
    @State private var emailText: String = ""
    @State private var passwordText: String = ""
    @State private var username: String = ""
    
    @EnvironmentObject var viewModel: AlertViewModel
    
    var body: some View {
        VStack (spacing: 14) {
            VStack(alignment: .center,spacing: 8) {
                Text("My Medium")
                    .appTextStyle()
                Text(screnType.isCreateAccount ?? true ? "Create account to join us." : "Login using Email And Password")
                    .font(.footnote)
            }
            if screnType.isCreateAccount ?? true {
                AppInputBox(
                    leftIcon: AppIconsSF.userIcon,
                    placeHoldr: "User Name",
                    keyboard: AppKeyBoardType.default,
                    title:"User Name", value: $username
                )
            } else {
                /*@START_MENU_TOKEN@*/EmptyView()/*@END_MENU_TOKEN@*/
            }
            AppInputBox(
                leftIcon: AppIconsSF.emailIcon,
                placeHoldr: "Email",
                keyboard: AppKeyBoardType.emailAddress,
                title:"Email", value: $emailText
            )
            .onChange(of: emailText) { newValue in
                let result = Helpers.isVaildEmailRegx(text: emailText)
            }
            AppInputBox(
                leftIcon: AppIconsSF.passwordIcon,
                placeHoldr: "Password",
                keyboard: AppKeyBoardType.default,
                title:"Password", value: $passwordText
            )
            HStack {
                Spacer()
                Button(action: {}) {
                    Text("Forgot Password")
                        .background(
                            Rectangle()
                                .fill(Color.accentColor)
                                .frame(height:4)
                                .cornerRadius(22)
                                .offset(x: 0, y:14)
                        )
                }
            }
            AppButton(text: screnType.isCreateAccount ?? true ? "Sign Up": "Login", clicked: {
                if screnType.isCreateAccount == false {
                    UserLoginApi(email: emailText, password: passwordText)
                    return
                }
            })
            .padding(.top)
            Spacer()
            Button(action: toggleLoginState) {
                Text(screnType.isCreateAccount ?? true ? "all rady have an account?\nLogin here" : "Dont have an account?\n Create here")
                    .font(.headline)
            }
        }
        .padding()
        .navigationTitle(screnType.isCreateAccount ?? true ? "Create Account":"Login")
    }
    
    func toggleLoginState()  {
        withAnimation {
            screnType.isCreateAccount = !(screnType.isCreateAccount ?? false)
        }
    }
    
    func UserLoginApi(email : String,password : String) {
        viewModel.alertToast = AppMessage.loadindView
        let postData: [String: Any] = [
            "email" : "eve.holt@reqres.in",
            "password":"cityslicka"
        ]
        let user: [String:Any] = [
            "user": postData
        ]
        AuthServices().userLogin(parameters: user){
            result in
            switch result {
            case .success(_):
                print("2")
                withAnimation{
                    //                        isLogedIn = true
                }
            case .failure(let error):
                switch error {
                case .NetworkErrorAPIError(let errorMessage):
                    viewModel.toggle()
                    viewModel.errorMessage = errorMessage
                    print("3")
                    print(errorMessage)
                case .BadURL:
                    print("BadURL")
                case .NoData:
                    print("NoData")
                case .DecodingErrpr:
                    print("DecodingErrpr")
                }
            }
        }
    }
}

struct CreateAccountScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CreateAccountScreen()
                .environmentObject(AlertViewModel())
        }
    }
}
