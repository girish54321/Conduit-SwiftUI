//
//  CreateAccountScreen.swift
//  MyMedium
//
//  Created by na on 10/01/23.
//

import SwiftUI

struct CreateAccountScreen: View {
    @State var screenType: LoginScreenType = LoginScreenType(title: "Login", isCreateAccount: false)
    
    @State private var emailText: String = ""
    @State private var passwordText: String = ""
    @State private var username: String = ""
    
    @EnvironmentObject var appViewModel: AppViewModel
    @EnvironmentObject var authViewModel: AuthViewModel
    @AppStorage(AppConst.isSkipped) var isSkipped: Bool = false
    @AppStorage(AppConst.token) var token: String = ""
    
    var body: some View {
        VStack (spacing: 14) {
            VStack(alignment: .center,spacing: 8) {
                Text("My Medium")
                    .appTextStyle()
                Text(screenType.isCreateAccount ?? true ? "Create account to join us." : "Login using Email And Password")
                    .font(.footnote)
            }
            if screenType.isCreateAccount ?? true {
                AppInputBox(
                    leftIcon: AppIconsSF.userIcon,
                    placeHolder: "User Name",
                    keyboard: AppKeyBoardType.default,
                    title:"User Name", value: $username
                )
            } else {
                /*@START_MENU_TOKEN@*/EmptyView()/*@END_MENU_TOKEN@*/
            }
            AppInputBox(
                leftIcon: AppIconsSF.emailIcon,
                placeHolder: "Email",
                keyboard: AppKeyBoardType.emailAddress,
                title:"Email", value: $emailText
            )
            AppInputBox(
                leftIcon: AppIconsSF.passwordIcon,
                placeHolder: "Password",
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
            AppButton(text: screenType.isCreateAccount ?? true ? "Sign Up": "Login", clicked: {
                if screenType.isCreateAccount == false {
                    UserLoginApi(email: emailText, password: passwordText)
                    return
                }else {
                    crateUserApi(email: emailText, password: passwordText)
                }
            })
            .padding(.top)
            Spacer()
            Button(action: toggleLoginState) {
                Text(screenType.isCreateAccount ?? true ? "all ready have an account?\nLogin here" : "Don't have an account?\n Create here")
                    .font(.headline)
            }
        }
        .padding()
        .navigationTitle(screenType.isCreateAccount ?? true ? "Create Account":"Login")
    }
    
    func toggleLoginState()  {
        withAnimation {
            screenType.isCreateAccount = !(screenType.isCreateAccount ?? false)
        }
    }
    
    func crateUserApi(email : String,password : String) {
        appViewModel.alertToast = AppMessage.loadingView
        let postData: [String: Any] = [
            "username": username,
            "email" : email,
            "password": password
        ]
        let user: [String:Any] = [
            "user": postData
        ]
        AuthServices().createAccount(parameters: user){
            result in
            switch result {
            case .success(_):
                UserLoginApi(email: email, password: password)
            case .failure(let error):
                switch error {
                case .NetworkErrorAPIError(let errorMessage):
                    appViewModel.toggle()
                    appViewModel.errorMessage = errorMessage
                case .BadURL: break
                case .NoData: break
                case .DecodingError: break
                }
            }
        }
    }
    
    func UserLoginApi(email : String,password : String) {
        appViewModel.alertToast = AppMessage.loadingView
        let postData: [String: Any] = [
            "email" : email,
            "password": password
        ]
        let user: [String:Any] = [
            "user": postData
        ]
        AuthServices().userLogin(parameters: user){
            result in
            switch result {
            case .success(let data):
                withAnimation {
                    token = data.user?.token ?? ""
                }
                authViewModel.saveUser(data: data)
            case .failure(let error):
                switch error {
                case .NetworkErrorAPIError(let errorMessage):
                    appViewModel.toggle()
                    appViewModel.errorMessage = errorMessage
                case .BadURL: break
                case .NoData: break
                case .DecodingError: break
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
