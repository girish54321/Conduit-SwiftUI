//
//  AboutAuthorView.swift
//  MyMedium
//
//  Created by na on 18/01/23.
//

import SwiftUI

struct AboutAuthorView: View {
    @EnvironmentObject var articleViewModal: ArticleViewModel
    @EnvironmentObject var feedViewModal: FeedArticleViewModel
    
    var body: some View {
        VStack(alignment: .center) {
            AppNetworkImage(imageUrl: articleViewModal.selectedArticle.author?.image ?? "")
                .frame(width: 50, height: 50)
                .clipShape(
                    RoundedRectangle(cornerRadius: 12)
                )
                .shadow(radius: 2)
            Text(articleViewModal.selectedArticle.author?.username ?? "Name")
                .font(.title2)
                .padding(2) 
            Text(articleViewModal.selectedArticle.author?.bio ?? "Bio")
                .font(.headline)
                .foregroundColor(.gray)
                .lineLimit(nil)
            Button(action: {
                if(articleViewModal.selectedArticle.author?.following == true){
                    deleteFollow()
                } else {
                    followUser()
                }
            }) {
                Text(articleViewModal.selectedArticle.author?.following == true ? "UnFollow" : "Follow")
                    .foregroundColor(.white)
                    .padding(8)
                    .background(articleViewModal.selectedArticle.author?.following == true ? Color.red : Color.green)
                    .cornerRadius(5)
                    .animation(.easeIn, value: articleViewModal.selectedArticle.author?.following)
            }
            
        }
    }
    
    func deleteFollow() {
        ProfileServices().removeFollow(parameters: nil, endpoint: "\(articleViewModal.selectedArticle.author?.username ?? "")/follow"){
            res in
            switch res {
            case .success(let data):
                print("Done deleteFollow")
                articleViewModal.selectedArticle.author?.following = data.profile?.following
                articleViewModal.getArticles()
                feedViewModal.getArticles()
                print(data)
            case .failure(let error):
                switch error {
                case .NetworkErrorAPIError(let errorMessage):
                    print("3")
                    print(errorMessage)
                case .BadURL:
                    print("BadURL")
                case .NoData:
                    print("NoData")
                case .DecodingError:
                    print("DecodingError")
                }
            }
        }
    }
    
    func followUser() {
        ProfileServices().requestFollow(parameters: nil, endpoint: "\(articleViewModal.selectedArticle.author?.username ?? "")/follow"){
            res in
            switch res {
            case .success(let data):
                print(data)
                print("Done followUser")
                articleViewModal.selectedArticle.author?.following = data.profile?.following
                articleViewModal.getArticles()
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
                case .DecodingError:
                    print("DecodingError")
                }
            }
        }
    }
}

struct AboutAuthorView_Previews: PreviewProvider {
    static var previews: some View {
        AboutAuthorView()
            .environmentObject(ArticleViewModel())
            .environmentObject(FeedArticleViewModel())
        
    }
}
