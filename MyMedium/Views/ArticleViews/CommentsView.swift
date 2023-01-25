//
//  CommentsView.swift
//  MyMedium
//
//  Created by Girish Parate on 25/01/23.
//

import SwiftUI

struct CommentsView: View {
    @State var coment: Comment?
    var body: some View {
        HStack(alignment: .center) {
            AppNetworkImage(imageUrl: coment?.author?.image ?? DummyData().autherData.image!)
                .frame(width: 44, height: 44)
                .clipShape(
                    RoundedRectangle(cornerRadius: 12)
                )
                .shadow(radius: 2)
            VStack (alignment:.leading,spacing: 7) {
                Text(coment?.author?.username ?? "Name")
                    .font(.headline)
                    .padding(.top)
                Text(coment?.body ?? "Bio")
                    .font(.headline)
                    .foregroundColor(.gray)
                    .padding(.bottom)
            }
            Spacer()
        }
    }
}

struct CommentsView_Previews: PreviewProvider {
    static var previews: some View {
        CommentsView()
    }
}
