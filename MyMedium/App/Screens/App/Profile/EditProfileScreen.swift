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
    @EnvironmentObject var authViewModel: AuthViewModel
    
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
                    title:"User Name", value: $userparms.username)
                AppInputBox(
                    leftIcon: AppIconsSF.emailIcon,
                    placeHolder: "Email",
                    keyboard: AppKeyBoardType.emailAddress,
                    title:"Email", value: $userparms.email)
                AppInputBox(
                    leftIcon: AppIconsSF.userIcon,
                    placeHolder: "Bio",
                    keyboard: AppKeyBoardType.default,
                    title:"Bio", value: $userparms.bio)
                AppInputBox(
                    leftIcon: AppIconsSF.passwordIcon,
                    placeHolder: "Password",
                    passwordView: SecureField("Password", text: $userparms.password),
                    keyboard: AppKeyBoardType.default,
                    title:"Password", value: $userparms.password)
            }
            .padding()
            AppButton(text: "Save", clicked: {
                
            })
            .padding()
        }
            .navigationTitle("Profile")
    }
}

struct EditProfileScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            EditProfileScreen()
                .environmentObject(AuthViewModel())
        }
    }
}
