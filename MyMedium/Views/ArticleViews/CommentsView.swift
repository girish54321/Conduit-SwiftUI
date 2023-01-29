//
//  CommentsView.swift
//  MyMedium
//
//  Created by Girish Parate on 25/01/23.
//

import SwiftUI

struct CommentsView: View {
    @State var comment: Comment?
    @EnvironmentObject var authViewModel: AuthViewModel
    var clicked: ((Comment) -> Void)
    var body: some View {
        HStack(alignment: .center) {
            AppNetworkImage(imageUrl: comment?.author?.image ?? DummyData().authorData.image!)
                .frame(width: 44, height: 44)
                .clipShape(
                    RoundedRectangle(cornerRadius: 12)
                )
                .shadow(radius: 2)
            VStack (alignment:.leading,spacing: 7) {
                Text(comment?.author?.username ?? "Name")
                    .font(.headline)
                    .padding(.top)
                Text(comment?.body ?? "Bio")
                    .font(.headline)
                    .foregroundColor(.gray)
                    .padding(.bottom)
            }
            Spacer()
            if authViewModel.isLoggedIn && authViewModel.userState?.user?.username == comment?.author?.username {
                Button(action: {
                    clicked(comment!)
                }, label: {
                    Image(systemName: AppIconsSF.removeIcon)
                        .foregroundColor(.red)
                })
                .padding()
            } else {
                /*@START_MENU_TOKEN@*/EmptyView()/*@END_MENU_TOKEN@*/
            }
        }
    }
}

struct CommentsView_Previews: PreviewProvider {
    
    var clicked: ((Comment) -> Void)
    
    static var previews: some View {
        CommentsView(clicked: {_ in
            
        })
        .environmentObject(AuthViewModel())
    }
}
