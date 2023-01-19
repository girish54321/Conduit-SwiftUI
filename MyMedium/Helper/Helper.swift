//
//  Helper.swift
//  MyMedium
//
//  Created by neosoft on 11/01/23.
//

import Foundation
struct Helpers {
    static func isVaildEmailRegx(text:String) -> Bool {
        var isValidEmail = false
        let result = text.range(
            of: AppConst.emailPattern,
            options: .regularExpression
        )
        isValidEmail = (result != nil)
        return isValidEmail
    }
    
    static func isValidPassword(text:String) -> Bool {
        var isValidPassword = false
        
        if text.count >= 6 {
            isValidPassword = true
        } else {
            isValidPassword = false
        }
        return isValidPassword
    }
    
    static func isTheOwner (user: User?, author: Author?) -> Bool {
        if (user?.username != author?.username) {
            return false
        }
        return true
    }
}
