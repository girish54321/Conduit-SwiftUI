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
    
    var passwordView: SecureField<Text>?
    var keyboard: Int?
    
    var state: Bool?
    var title: String?
    
    @Binding var value: String
    
    var body: some View {
        VStack (alignment: .leading, spacing: 4) {
            Text(title ?? "")
                .font(.headline)
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
                            TextField(placeHoldr, text: $value)
                                .keyboardType(UIKeyboardType(rawValue: keyboard!) ?? .default)
                        } else {
                            passwordView
                        }
                    }
                    if rightIcon != nil && state != nil {
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
            .inputTextStyle()
        .frame(height: 55)
        }
    }
}

struct AppInputBox_Previews: PreviewProvider {
    @State static var emailText: String = "projectedValue"
    static var previews: some View {
        Group {
            AppInputBox(leftIcon: "heart.text.square",
                        rightIcon: "checkmark.circle.fill",
                        placeHoldr: "Placeholder",
                        value: $emailText)
            .previewLayout(.sizeThatFits)
            .padding()
            AppInputBox(leftIcon: "heart.text.square",
                        placeHoldr: "Placeholder", value: $emailText)
            .previewLayout(.sizeThatFits)
            .padding()
            AppInputBox(rightIcon: "checkmark.circle.fill",
                        placeHoldr: "Placeholder",value: $emailText)
            .previewLayout(.sizeThatFits)
            .padding()
            AppInputBox(placeHoldr: "Placeholder",value: $emailText)
                .previewLayout(.sizeThatFits)
                .padding()
        }
    }
}
