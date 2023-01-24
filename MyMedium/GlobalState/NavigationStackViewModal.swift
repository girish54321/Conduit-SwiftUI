//
//  NavigationStackViewModal.swift
//  MyMedium
//
//  Created by neosoft on 19/01/23.
//

import Foundation
import SwiftUI

class FeedNavigationStackViewModal: ObservableObject {
    @Published var presentedScreen = NavigationPath()
}

class TrandingNavigationStackViewModal: ObservableObject {
    @Published var presentedScreen = NavigationPath()
}

class ProfileNavigationStackViewModal: ObservableObject {
    @Published var presentedScreen = NavigationPath()
}
