//
//  LoginPlaceHolder.swift
//  Conduit
//
//  Created by Girish Parate on 24/01/23.
//

import SwiftUI

struct LoginPlaceHolder: View {
    
    @State var title: String = ""
    @AppStorage(AppConst.isSkipped) var isSkipped: Bool = false
    @AppStorage(AppConst.token) var token: String = ""
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        VStack {
            if !authViewModel.isLoading {
                VStack {
                    Image(systemName: AppIconsSF.userIcon)
                        .imageModifier()
                        .foregroundColor(Color.accentColor)
                        .frame(width: 170,height: 170)
                    
                    Text("Login to " + title + ".")
                        .font(.largeTitle)
                    
                    AppButton(text: "Login", isDisabled: false, clicked: {
                        isSkipped = false
                        token = ""
                    })
                    .padding(.vertical)
                    .frame(width: 120)
                    
                }
            } else {
                LoadingListing()
            }
        }
    }
}

struct LoginPlaceHolder_Previews: PreviewProvider {
    static var previews: some View {
        LoginPlaceHolder(title: "Login")
            .environmentObject(AuthViewModel())
    }
}
