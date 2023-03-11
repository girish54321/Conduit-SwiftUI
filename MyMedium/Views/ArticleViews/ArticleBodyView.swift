//
//  ArticleBodyView.swift
//  MyMedium
//
//  Created by Girish Parate on 11/03/23.
//

import SwiftUI

struct ArticleBodyView: View {
    
    var title: String?
    var bodyText: String?
    
    var body: some View {
        VStack {
            AppNetworkImage(imageUrl: "https://picsum.photos/300")
                .frame(minWidth: 0, maxWidth: .infinity)
                .aspectRatio(contentMode: .fill)
                .clipped()
                .cornerRadius(10)
                .shadow(radius: 10)
                .transition(.move(edge: .bottom))
                .animation(.spring(), value: title)
                .padding()
            Text(title ?? "NA")
                .foregroundColor(.white)
                .padding()
                .background(Color.black.opacity(0.5))
                .cornerRadius(10)
                .shadow(radius: 10)
                .transition(.move(edge: .bottom))
                .animation(.spring(), value: title)
                .padding()
            Text(UIHelper().formateHelptext(text: bodyText ?? ""))
                .padding()
        }
    }
}

struct ArticleBodyView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleBodyView()
    }
}
