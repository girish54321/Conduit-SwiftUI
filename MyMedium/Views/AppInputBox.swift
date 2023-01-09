//
//  AppInputBox.swift
//  MyMedium
//
//  Created by neosoft on 09/01/23.
//

import SwiftUI

struct AppInputBox: View {
    
    var leftIcon: String?
    var rightIcon: String?
    var placeHoldr: String
    
    var view: TextField<Text>?
    var passwordView: SecureField<Text>?
    var keyboard: Int?
    
    var state: Bool?
    
    var body: some View {
        VStack {
            HStack (spacing:8) {
                if leftIcon != nil {
                    Image(systemName:leftIcon!)
                        .inputIconStyle()
                        .padding(.leading,8)
                        .foregroundColor(Color.accentColor)
                        .animation(.easeIn(duration: 3), value:leftIcon ?? "")
                } else {
                    Spacer()
                }
                VStack {
                    if keyboard != nil{
                        view
                            .keyboardType(UIKeyboardType(rawValue: keyboard!) ?? .default)
                    } else if view != nil {
                        view
                    } else {
                        passwordView
                    }
                }
                if rightIcon != nil {
                    Image(systemName:rightIcon ?? "")
                        .inputIconStyle()
                        .padding(.trailing,8)
                        .foregroundColor( state == nil ? .accentColor : state ?? true ? .green : .red)
                        .animation(.easeIn(duration: 0.3), value:rightIcon ?? "")
                } else {
                    Spacer()
                }
            }
        }
        .background(
            Rectangle()
                .fill(Color.gray.opacity(0.05))
                .frame(height: 55)
                .cornerRadius(4)
        )
        .frame(height: 55)
    }
}

struct AppInputBox_Previews: PreviewProvider {
    @State static var emailText: String = "projectedValue"
    static var previews: some View {
        Group {
            AppInputBox(leftIcon: "heart.text.square",
                        rightIcon: "checkmark.circle.fill",
                        placeHoldr: "Placeholder",
                        view: TextField("Plasw", text: $emailText))
                .previewLayout(.sizeThatFits)
                .padding()
            AppInputBox(leftIcon: "heart.text.square",
                        placeHoldr: "Placeholder")
                .previewLayout(.sizeThatFits)
                .padding()
            AppInputBox(rightIcon: "checkmark.circle.fill",
                        placeHoldr: "Placeholder")
                .previewLayout(.sizeThatFits)
                .padding()
            AppInputBox(placeHoldr: "Placeholder")
                .previewLayout(.sizeThatFits)
                .padding()
        }
    }
}
