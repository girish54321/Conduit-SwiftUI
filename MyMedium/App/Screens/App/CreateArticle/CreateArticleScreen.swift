//
//  CreateArticleScreen.swift
//  Conduit
//
//  Created by na on 17/01/23.
//

import SwiftUI
import AlertToast

let PlaceHolder = ArticleParams(title: "", description: "", body: "", tagList: [])

struct CreateArticleScreen: View {
    
    @State var article = PlaceHolder
    @State var activeStack: AppNavStackType
    @State var slug: String?
    @EnvironmentObject var appViewModel: AppViewModel
    @EnvironmentObject var articleViewModal: ArticleViewModel
    @EnvironmentObject var feedNavStack: FeedNavigationStackViewModal
    @EnvironmentObject var articleStack: TradingNavigationStackViewModal
    @EnvironmentObject var profileStack: ProfileNavigationStackViewModal
    @EnvironmentObject var feedViewModal: FeedArticleViewModel
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        VStack {
            if authViewModel.isLoggedIn {
                VStack {
                    ScrollView {
                        VStack(alignment: .leading) {
                            AppInputBox(
                                placeHolder: "Enter title here",
                                keyboard: AppKeyBoardType.default,
                                title:"Title", value: $article.title
                            )
                            AppInputBox(
                                placeHolder: "Enter description here",
                                keyboard: AppKeyBoardType.default,
                                title:"Description", value: $article.description
                            )
                            Text("Body").font(.headline)
                            VStack {
                                TextEditor(text: $article.body)
                                    .border(Color.gray)
                            }
                            .inputTextStyle()
                            .frame(height:240)
                            HStack {
                                ForEach(article.tagList , id: \.self) { data in
                                    ChipView(title: data)
                                }
                            }
                            Spacer()
                        }
                        .padding()
                    }
                    AppButton(text: "Save", clicked: {
                        if (slug == nil){
                            uploadArticle()
                        } else {
                            updateArticle()
                        }
                    })
                    .padding()
                }
            } else {
                LoginPlaceHolder(title: "Create \nArticle")
//                    .padding(.horizontal,1)
            }
        }
        .navigationTitle("Create Article")
    }
    
    func updateArticle () {
        let parameters = RequestParams(article: article)
        ArticleServices().updateArticle(parameters: parameters.toDictionary(), endpoint: slug!){
            result in
            switch result {
            case .success(let resData):
                articleViewModal.selectedArticle = resData.article!
                articleViewModal.updateSelectedArticle(article: resData.article!)
                feedViewModal.updateSelectedFeedArticle(article: resData.article!)
                feedViewModal.getArticles()
                articleViewModal.getArticles()
                switch activeStack {
                case .feed:
                    feedNavStack.presentedScreen.removeLast()
                case .article:
                    articleStack.presentedScreen.removeLast()
                case .profile:
                    profileStack.presentedScreen.removeLast()
                case .root:
                    break
                }
            case .failure(let error):
                switch error {
                case .NetworkErrorAPIError(let errorMessage):
                    print(errorMessage)
                    appViewModel.errorMessage = errorMessage
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
    
    func uploadArticle () {
        let parameters = RequestParams(article: article)
        ArticleServices().uploadArticle(parameters: parameters.toDictionary()){
            result in
            switch result {
            case .success(_):
                article = PlaceHolder
                feedViewModal.getArticles()
                articleViewModal.getArticles()
            case .failure(let error):
                switch error {
                case .NetworkErrorAPIError(let errorMessage):
                    print(errorMessage)
                    appViewModel.errorMessage = errorMessage
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
    
    func clearInputs () {
        withAnimation {
            article = PlaceHolder
        }
    }
}

struct CreateArticleScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CreateArticleScreen(activeStack: .feed)
                .environmentObject(AppViewModel())
                .environmentObject(FeedNavigationStackViewModal())
                .environmentObject(AuthViewModel())
                .environmentObject(TradingNavigationStackViewModal())
        }
    }
}
