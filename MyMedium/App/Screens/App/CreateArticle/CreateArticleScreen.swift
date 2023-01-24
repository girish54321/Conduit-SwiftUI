//
//  CreateArticleScreen.swift
//  MyMedium
//
//  Created by neosoft on 17/01/23.
//

import SwiftUI
import AlertToast

let placHoder = ArticleParams(title: "", description: "", body: "", tagList: [])

struct CreateArticleScreen: View {
    
    @State var article = placHoder
    @State var activeStack: AppNavStackType
    @State var slug: String?
    @EnvironmentObject var appViewModel: AppViewModel
    @EnvironmentObject var articleViewModal: ArticleViewModel
    @EnvironmentObject var feedNavStack: FeedNavigationStackViewModal
    @EnvironmentObject var articleStack: TrandingNavigationStackViewModal
    @EnvironmentObject var profileStack: ProfileNavigationStackViewModal
    @EnvironmentObject var feedViewModal: FeedArticleViewModel
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading) {
                    AppInputBox(
                        placeHoldr: "Enter title here",
                        keyboard: AppKeyBoardType.default,
                        title:"Title", value: $article.title
                    )
                    AppInputBox(
                        placeHoldr: "Enter description here",
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
                    uploadAricle()
                } else {
                    updateArticle()
                }
            })
            .padding()
            .navigationTitle("Create Article")
        }
        
    }
    
    func updateArticle () {
        print("Update article")
        let parameters = RequestParams(article: article)
        ArticleServices().updateArticle(parameters: parameters.toDictionary(), endpoint: slug!){
            result in
            switch result {
            case .success(let resData):
                print("Done")
//                appViewModel.alertToast = AlertToast(displayMode: .banner(.slide), type: .complete(.green), title: "Your article has been successfully uploaded. Thank you for your submission!")
                print(resData.article?.author)
                articleViewModal.selectedArticle = resData.article!
                articleViewModal.updateSelectedArticle(article: resData.article!)
                feedViewModal.updateSelectedFeedArticle(article: resData.article!)
                switch activeStack {
                case .feed:
                    feedNavStack.presentedScreen.removeLast()
                case .article:
                    articleStack.presentedScreen.removeLast()
                case .profile:
                    profileStack.presentedScreen.removeLast()
                }
            case .failure(let error):
                switch error {
                case .NetworkErrorAPIError(let errorMessage):
                    print("3")
                    print(errorMessage)
                    appViewModel.errorMessage = errorMessage
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
    
    func uploadAricle () {
        let parameters = RequestParams(article: article)
        ArticleServices().uploadArticle(parameters: parameters.toDictionary()){
            result in
            switch result {
            case .success(_):
                print("Done")
                appViewModel.alertToast = AlertToast(displayMode: .banner(.slide), type: .complete(.green), title: "Your article has been successfully uploaded. Thank you for your submission!")
            case .failure(let error):
                switch error {
                case .NetworkErrorAPIError(let errorMessage):
                    print("3")
                    print(errorMessage)
                    appViewModel.errorMessage = errorMessage
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
    
    func clearInputs () {
        withAnimation {
            article = placHoder
        }
    }
}

struct CreateArticleScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CreateArticleScreen(activeStack: .feed)
                .environmentObject(AppViewModel())
                .environmentObject(FeedNavigationStackViewModal())
                .environmentObject(TrandingNavigationStackViewModal())
        }
    }
}
