//
//  LoadingListing.swift
//  MyMedium
//
//  Created by Girish Parate on 21/01/23.
//

import SwiftUI
import Shimmer

struct LoadingListing: View {
    var body: some View {
        List([DummyData().data,DummyData().data,DummyData().data,DummyData().data,DummyData().data]) { article in
            Button (action: {
                
            }, label: {
                HStack {
                    ArticleRow(article: article)
                }
                .redacted(reason: .placeholder)
                .shimmering()
            })
            .buttonStyle(.plain)
        }
    }
}

struct LoadingListing_Previews: PreviewProvider {
    static var previews: some View {
        LoadingListing()
    }
}
