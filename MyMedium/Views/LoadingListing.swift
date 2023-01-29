//
//  LoadingListing.swift
//  MyMedium
//
//  Created by Girish Parate on 21/01/23.
//

import SwiftUI
import Shimmer

struct LoadingArticleItem: View {
    var article: Article
    var body: some View {
        HStack {
            ArticleRow(article: article)
        }
        .redacted(reason: .placeholder)
        .shimmering()
    }
}

struct LoadingListing: View {
    var body: some View {
        List([DummyData().data,DummyData().data,DummyData().data,DummyData().data,DummyData().data]) { article in
            Button (action: {
                
            }, label: {
                LoadingArticleItem(article: article)
            })
            .buttonStyle(.plain)
        }
    }
}

struct LoadingForEachListing: View {
    var body: some View {
        ForEach([DummyData().data,DummyData().data]) { article in
            VStack {
                HStack {
                    LoadingArticleItem(article: article)
                    Spacer()
                }
                Divider()
            }
        }
    }
}

struct LoadingListing_Previews: PreviewProvider {
    static var previews: some View {
        LoadingListing()
    }
}
