//
//  ArticleRow.swift
//  MyMedium
//
//  Created by neosoft on 16/01/23.
//

import SwiftUI

struct ArticleRow: View {
    var article: Article?
    @EnvironmentObject var appViewModal: AppViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(article?.title ?? "NA")
                .font(.headline)
                .lineLimit(2)
            Text(article?.description ?? "NA")
                .font(.subheadline)
                .lineLimit(2)
                .padding(.top,4)
            HStack {
                ForEach(article?.tagList ?? [], id: \.self) { data in
                    ChipView(title: data)
                }
            }
            HStack {
                Text(Helpers.formatDateFormat(dateString: article?.createdAt ?? ""))
                Spacer()
                Button(action: {

                }) {
                    Image(systemName: article?.favorited ?? false ? AppIconsSF.bookMarkFillIcon : AppIconsSF.bookMarkIcon)
                        .frame(width: 30,height: 30)
                        .animation(.spring(), value: article?.favorited ?? false)
                }
                .frame(width: 30,height: 30)
            }
        }
    }
}

struct ArticleRow_Previews: PreviewProvider {
    static var previews: some View {
        ArticleRow(article: DummyData().data)
            .padding()
    }
}
