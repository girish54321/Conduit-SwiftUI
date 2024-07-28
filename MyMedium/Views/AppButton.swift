//
//  AppButton.swift
//  Conduit
//
//  Created by na on 09/01/23.
//

import SwiftUI

struct AppButton: View {
    
    var text: String
    var leftIcon: Image?
    var rightIcon: Image?
    var isDisabled: Bool
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
            .background(isDisabled ? Color.gray.opacity(0.5) : Color("ButtonColor"))
            .overlay(
                RoundedRectangle(cornerRadius: 6)
                    .stroke(isDisabled ? Color.gray : Color.accentColor, lineWidth: 3)
            )
            .cornerRadius(6)
        }
        .disabled(isDisabled)
    }
    
    struct AppButton_Previews: PreviewProvider {
        static var previews: some View {
            AppButton(text: "Login", rightIcon: Image(systemName: "plus"), isDisabled: false, clicked: {
            }).previewLayout(.sizeThatFits).padding()
            AppButton(text: "Login",rightIcon: Image(systemName: "plus"), isDisabled: false, clicked: {
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
