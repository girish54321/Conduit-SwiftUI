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
    
    @EnvironmentObject var appViewModel: AppViewModel
    @EnvironmentObject var authViewModel: AuthViewModel
    @AppStorage(AppConst.isSkiped) var isSkiped: Bool = false
    @AppStorage(AppConst.tokan) var tokan: String = ""
    
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
                }else {
                    crateUserApi(email: emailText, password: passwordText)
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
    
    func crateUserApi(email : String,password : String) {
        appViewModel.alertToast = AppMessage.loadindView
        let postData: [String: Any] = [
            "username": "test",
            "email" : "test",
            "password":"23"
        ]
        let user: [String:Any] = [
            "user": postData
        ]
        AuthServices().createAccount(parameters: user){
            result in
            switch result {
            case .success(_):
                print("Done")
            case .failure(let error):
                switch error {
                case .NetworkErrorAPIError(let errorMessage):
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
    
    func UserLoginApi(email : String,password : String) {
        appViewModel.alertToast = AppMessage.loadindView
        print("login")
        let postData: [String: Any] = [
            "email" : "samsungceo@mail.com",
            "password": "djffdk23!23"
        ]
        let user: [String:Any] = [
            "user": postData
        ]
        AuthServices().userLogin(parameters: user){
            result in
            switch result {
            case .success(let data):
                withAnimation {
                    tokan = data.user?.token ?? ""
                }
                authViewModel.saveUser(data: data)
            case .failure(let error):
                switch error {
                case .NetworkErrorAPIError(let errorMessage):
                    appViewModel.toggle()
                    appViewModel.errorMessage = errorMessage
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
                .environmentObject(AppViewModel())
        }
    }
}
