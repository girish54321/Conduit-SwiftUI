//
//  EditProfileScreen.swift
//  MyMedium
//
//  Created by Girish Parate on 03/02/23.
//

import SwiftUI

let plachHolder = UserUpdateParms(email: "", password: "", username: "", bio: "", image: "")

struct EditProfileScreen: View {
    @State var userparms: UserUpdateParms = plachHolder
    @EnvironmentObject var appViewModel: AppViewModel
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var profileStack: ProfileNavigationStackViewModal
    @AppStorage(AppConst.isSkipped) var isSkipped: Bool = false
    @AppStorage(AppConst.token) var token: String = ""
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Spacer()
                    AppNetworkImage(imageUrl: authViewModel.userState?.user?.image ?? "https://media5.bollywoodhungama.in/wp-content/uploads/2021/03/WhatsApp-Image-2021-03-26-at-5.08.26-PM.jpeg")
                        .frame(width: 110, height: 110)
                        .clipShape(
                            RoundedRectangle(cornerRadius: 12)
                        )
                    Spacer()
                }
                .padding(.bottom)
                AppInputBox(
                    leftIcon: AppIconsSF.userIcon,
                    placeHolder: "User Name",
                    keyboard: AppKeyBoardType.default,
                    title:"User Name", value: $userparms.username.toUnwrapped(defaultValue: ""))
                AppInputBox(
                    leftIcon: AppIconsSF.emailIcon,
                    placeHolder: "Email",
                    keyboard: AppKeyBoardType.emailAddress,
                    title:"Email", value: $userparms.email.toUnwrapped(defaultValue: ""))
                AppInputBox(
                    leftIcon: AppIconsSF.userIcon,
                    placeHolder: "Bio",
                    keyboard: AppKeyBoardType.default,
                    title:"Bio", value: $userparms.bio.toUnwrapped(defaultValue: ""))
                AppInputBox(
                    leftIcon: AppIconsSF.passwordIcon,
                    placeHolder: "Password",
                    passwordView: SecureField("Password", text: $userparms.password.toUnwrapped(defaultValue: "")),
                    title:"Password", value: $userparms.password.toUnwrapped(defaultValue: ""))
            }
            .padding()
            AppButton(text: "Save", clicked: {
                updateProfile()
            })
            .padding()
        }
            .navigationTitle("Edit Profile")
    }
    
    func updateProfile () {
        AuthServices().updateAccount(parameters: userparms.toDictionary(), completion: { res in
            switch res {
            case .success(_):
                profileStack.presentedScreen.removeLast()
                isSkipped = false
                token = ""
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
        })
    }
}

struct EditProfileScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            EditProfileScreen()
                .environmentObject(AuthViewModel())
                .environmentObject(AppViewModel())
                .environmentObject(ProfileNavigationStackViewModal())
        }
    }
}
