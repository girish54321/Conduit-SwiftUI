//
//  NavigationStackViewModal.swift
//  Conduit
//
//  Created by na on 19/01/23.
//

import Foundation
import SwiftUI

class FeedNavigationStackViewModal: ObservableObject {
    @Published var presentedScreen = NavigationPath()
}

class TradingNavigationStackViewModal: ObservableObject {
    @Published var presentedScreen = NavigationPath()
}

class ProfileNavigationStackViewModal: ObservableObject {
    @Published var presentedScreen = NavigationPath()
}
