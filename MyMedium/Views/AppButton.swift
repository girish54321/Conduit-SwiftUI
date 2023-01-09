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
    var whiteButton: Bool?
    var clicked: (() -> Void)
    
    var body: some View {
        Button(action: clicked) {
            HStack {
                leftIcon ?? leftIcon
                Spacer()
                Text(text).fontWeight(.semibold)
                rightIcon ?? rightIcon
                Spacer()
            }
            .frame(height:25)
            .padding(12)
            .background(whiteButton != nil ? Color.white: Color.accentColor)
            .foregroundColor(  whiteButton != nil ? .black: .white)
            .overlay(
                RoundedRectangle(cornerRadius: 6)
                    .stroke(Color.blue, lineWidth: 3)
            )
            .cornerRadius(6)
        }
    }
    
    struct AppButton_Previews: PreviewProvider {
        static var previews: some View {
            AppButton(text: "Login", rightIcon: Image(systemName: "plus"), clicked: {
                print("Clicked!")
            }).previewLayout(.sizeThatFits).padding()
            AppButton(text: "Login",rightIcon: Image(systemName: "plus"), whiteButton: true,  clicked: {
                print("Clicked!")
            }).previewLayout(.sizeThatFits).padding()
        }
    }
}
