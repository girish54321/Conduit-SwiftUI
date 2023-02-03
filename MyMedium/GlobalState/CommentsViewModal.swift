//
//  CommentsViewModal.swift
//  Conduit
//
//  Created by Girish Parate on 23/01/23.
//

import Foundation
class CommentsViewModel: ObservableObject {
    
    @Published var show = false
    
    func toggle() {
        show.toggle()
    }
    
    @Published var showAlert = false
    @Published var errorMessage = "" {
        didSet {
            showAlert.toggle()
        }
    }
}
