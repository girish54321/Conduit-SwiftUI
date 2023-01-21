//
//  ArticleViewModal.swift
//  MyMedium
//
//  Created by Girish Parate on 21/01/23.
//

import Foundation
class ArticleViewModel: ObservableObject {
    
    @Published var isLogedin = false
    @Published var tokan: String? = nil
    @Published var userState: LoginScuccess? = nil
    
    func saveUser(data:LoginScuccess)  {
        print(data.user?.email)
        userState = data
    }
}
