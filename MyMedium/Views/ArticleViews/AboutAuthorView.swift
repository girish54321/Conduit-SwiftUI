//
//  AboutAuthorView.swift
//  MyMedium
//
//  Created by neosoft on 18/01/23.
//

import SwiftUI

struct AboutAuthorView: View {
    @State var author: Author?
    @EnvironmentObject var feedViewModal: FeedArticleViewModel
    var body: some View {
        VStack(alignment: .center) {
            AppNetworkImage(imageUrl: author?.image ?? "")
                .frame(width: 50, height: 50)
                .clipShape(
                    RoundedRectangle(cornerRadius: 12)
                )
//                .overlay(Circle().stroke(Color.white, lineWidth: 2))
                .shadow(radius: 2)
            Text(author?.username ?? "Name")
                .font(.title2)
                .padding(2) 
            Text(author?.bio ?? "Bio")
                .font(.headline)
                .foregroundColor(.gray)
                .lineLimit(nil)
            Button(action: {
                if(author?.following == true){
                    deleteFollow()
                } else {
                    followUser()
                }
            }) {
                Text(author?.following == true ? "Unfollow" : "Follow")
                    .foregroundColor(.white)
                    .padding(8)
                    .background(author?.following == true ? Color.red : Color.green)
                    .cornerRadius(5)
            }
            
        }
    }
    
    func deleteFollow() {
        ProfileServices().removeFollow(parameters: nil, endpoint: "\(author?.username ?? "")/follow"){
            res in
            switch res {
            case .success(let data):
                print("Done deleteFollow")
                withAnimation {
                    author?.following = false
                }
                feedViewModal.getArticles()
            case .failure(let error):
                switch error {
                case .NetworkErrorAPIError(let errorMessage):
                    print("3")
                    print(errorMessage)
                case .BadURL:
                    print("BadURL")
                case .NoData:
                    print("NoData")
                case .DecodingErrpr:
                    print("DecodingErrpr")
                }
            }
        }
    }
    
    func followUser() {
        ProfileServices().requestFollow(parameters: nil, endpoint: "\(author?.username ?? "")/follow"){
            res in
            switch res {
            case .success(let data):
                print("Done followUser")
                withAnimation {
                    author?.following = true
                }
                feedViewModal.getArticles()
            case .failure(let error):
                switch error {
                case .NetworkErrorAPIError(let errorMessage):
                    print("3")
                    print(errorMessage)
                case .BadURL:
                    print("BadURL")
                case .NoData:
                    print("NoData")
                case .DecodingErrpr:
                    print("DecodingErrpr")
                }
            }
        }
    }
}

struct AboutAuthorView_Previews: PreviewProvider {
    static var previews: some View {
        AboutAuthorView(author: nil)
            .environmentObject(FeedArticleViewModel())
    }
}
