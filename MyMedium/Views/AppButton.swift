//
//  AppButton.swift
//  MyMedium
//
//  Created by neosoft on 09/01/23.
//

import SwiftUI

struct AppButton: View {
    
    var text: String
    var leftIcon: Image?
    var rightIcon: Image?
    var clicked: (() -> Void)
    
    var body: some View {
        Button(action: clicked) {
            HStack {
                leftIcon ?? leftIcon
                Spacer()
                Text(text).fontWeight(.semibold)
                    .foregroundColor(Color("ButtonText"))
                rightIcon ?? rightIcon
                Spacer()
            }
            .frame(height:25)
            .padding(12)
            .background(Color("ButtonColor"))
            .overlay(
                RoundedRectangle(cornerRadius: 6)
                    .stroke(Color.accentColor, lineWidth: 3)
            )
            .cornerRadius(6)
        }
    }
    
    struct AppButton_Previews: PreviewProvider {
        static var previews: some View {
            AppButton(text: "Login", rightIcon: Image(systemName: "plus"), clicked: {
                print("Clicked!")
            }).previewLayout(.sizeThatFits).padding()
            AppButton(text: "Login",rightIcon: Image(systemName: "plus"), clicked: {
                print("Clicked!")
            }).previewLayout(.sizeThatFits).padding()
        }
    }
}

struct SkipButton: View {
    var clicked: (() -> Void)
    var body: some View {
        Button(action: clicked){
            Text("Skip").foregroundColor(Color.accentColor).underline()
        }
    }
}
