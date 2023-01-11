//
//  AuthViewModal.swift
//  MyMedium
//
//  Created by neosoft on 11/01/23.
//

import Foundation
class AuthViewModel: ObservableObject {
    
    @Published var isLogedin = false
    @Published var tokan: String? = nil
    
    func saveUserTokan()  {
        
    }
}
