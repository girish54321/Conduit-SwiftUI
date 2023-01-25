//
//  LoginPlacHolder.swift
//  MyMedium
//
//  Created by Girish Parate on 24/01/23.
//

import SwiftUI

struct LoginPlacHolder: View {
    
    @State var title: String = ""
    @AppStorage(AppConst.isSkiped) var isSkiped: Bool = false
    @AppStorage(AppConst.tokan) var tokan: String = ""
    
    var body: some View {
        VStack {
            Image(systemName: AppIconsSF.userIcon)
                .imageModifier()
                .foregroundColor(.blue)
                .frame(width: 170,height: 170)
            
            Text("Login to " + title + ".")
                .font(.largeTitle)
            
            AppButton(text: "Login", clicked: {
                isSkiped = false
                tokan = ""
            })
            .padding(.vertical)
            .frame(width: 120)
            
        }
    }
}

struct LoginPlacHolder_Previews: PreviewProvider {
    static var previews: some View {
        LoginPlacHolder(title: "Login")
    }
}
