//
//  AlertViewModel.swift
//  MyMedium
//
//  Created by na on 11/01/23.
//

import Foundation
import AlertToast

class AppViewModel: ObservableObject {
    
    @Published var show = false
    @Published var alertToast = AlertToast(displayMode: .banner(.slide), type: .regular, title: "SOME TITLE"){
          didSet {
              show.toggle()
          }
      }
    
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
