//
//  AppHTMLView.swift
//  MyMedium
//
//  Created by Girish Parate on 21/01/23.
//

import SwiftUI
import SwiftSoup

struct AppHTMLView: View {
    var htmlString = "<p>Hello, <strong>World</strong>!</p>"
    var body: some View {
        Text(try! SwiftSoup.parse(htmlString.replacingOccurrences(of: "/n", with: "\n")).text())
            .lineLimit(nil)
               .fixedSize(horizontal: false, vertical: true)
               .multilineTextAlignment(.leading)
    }
}

struct AppHTMLView_Previews: PreviewProvider {
    static var previews: some View {
        AppHTMLView()
    }
}
