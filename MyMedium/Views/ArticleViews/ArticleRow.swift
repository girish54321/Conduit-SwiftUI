//
//  ArticleRow.swift
//  MyMedium
//
//  Created by neosoft on 16/01/23.
//

import SwiftUI

struct ArticleRow: View {
    var article: Article?
    var body: some View {
        VStack(alignment: .leading) {
            Text(article?.title ?? "NA")
                .font(.headline)
            Text(article?.description ?? "NA")
                .font(.subheadline)
                .padding(.top,4)
            HStack {
                ForEach(article?.tagList ?? [], id: \.self) { data in
                    ChipView(title: data)
                }
            }
        }
    }
}

struct ArticleRow_Previews: PreviewProvider {
    static var previews: some View {
        ArticleRow(article: nil)
            .padding()
    }
}
