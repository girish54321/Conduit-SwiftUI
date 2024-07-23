//
//  ArticleDetailViewScreen.swift
//  Conduit
//
//  Created by na on 18/01/23.
//

import SwiftUI
import AlertToast

struct ArticleDetailViewScreen: View {
    
    @EnvironmentObject var articleViewModal: ArticleViewModel
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var feedStack: FeedNavigationStackViewModal
    @EnvironmentObject var articleStack: TradingNavigationStackViewModal
    @EnvironmentObject var profileStack: ProfileNavigationStackViewModal
    @EnvironmentObject var feedViewModal: FeedArticleViewModel
    @State private var showDeleteAlert = false
    @EnvironmentObject var appViewModel: AppViewModel
    @State var isTheOwner : Bool = false
    @State var viewLoaded : Bool = false
    @State var activeStack: AppNavStackType
    
    @State private var comment: String = ""
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ArticleBodyView(title: articleViewModal.selectedArticle.title,
                                bodyText: articleViewModal.selectedArticle.body)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(articleViewModal.selectedArticle.tagList ?? [], id: \.self) { data in
                            ChipView(title: data)
                        }
                    }
                }
                .padding(.horizontal)
                HStack {
                    Text(Helpers.formatDateFormat(dateString: articleViewModal.selectedArticle.createdAt ?? ""))
                    Spacer()
                    Button(action: {
                        bookMarkArtie()
                    }) {
                        Image(systemName: articleViewModal.selectedArticle.favorited ?? false ? AppIconsSF.bookMarkFillIcon : AppIconsSF.bookMarkIcon)
                            .frame(width: 30,height: 30)
                    }
                    .frame(width: 30,height: 30)
                }
                .padding()
                AboutAuthorView()
                    .padding()
                    .onTapGesture {
                        let data = SelectedProfileScreenType(author: articleViewModal.selectedArticle.author!)
                        if (activeStack == .feed){
                            feedStack.presentedScreen.append(data)
                            return
                        }
                        if (activeStack == .article){
                            articleStack.presentedScreen.append(data)
                            return
                        }
                    }
            }
            HStack {
                if authViewModel.isLoggedIn {
                    AppInputBox(placeHolder: "Add your comments",
                                keyboard: AppKeyBoardType.default, value: $comment)
                    Button(action: {
                        addComment()
                    }) {
                        VStack {
                            Spacer()
                            Text("Post")
                                .padding()
                        }
                    }
                } else {
                    VStack {
                        Text("Please log in to post a comment.")
                        AppButton(
                            text: "Login",
                            clicked: {
                                let data = LoginScreenType(title: "Welcome Back", isCreateAccount: false)
                                articleStack.presentedScreen.append(data)
                            })
                    }
                }
            }
            .padding()
            .onAppear {
                if viewLoaded {
                    return
                }
                articleViewModal.getComments()
            }
            VStack {
                ForEach(articleViewModal.comments?.comments ?? [])
                { data in
                    CommentsView(comment: data, clicked: deleteComment)
                        .animation(.easeIn, value: articleViewModal.comments?.comments?.count)
                    Divider()
                }
            }
            .padding()
        }
        .refreshable {
            articleViewModal.getSignalArticle()
            articleViewModal.getComments()
        }
        .onAppear {
            if viewLoaded {
                return
            }
            withAnimation {
                isTheOwner = Helpers.isTheOwner (
                    user: authViewModel.userState?.user,
                    author: articleViewModal.selectedArticle.author
                )
                viewLoaded = true
            }
        }
        .navigationBarItems(
            trailing:
                VStack {
                    if isTheOwner {
                        HStack {
                            Button(action: {
                                let data = CreateArticleScreenType(selectedArticle: articleViewModal.selectedArticle)
                                if(activeStack == .feed){
                                    feedStack.presentedScreen.append(data)
                                    return
                                }
                                if (activeStack == .article){
                                    articleStack.presentedScreen.append(data)
                                    return
                                }
                                if (activeStack == .profile) {
                                    profileStack.presentedScreen.append(data)
                                    return
                                }
                            }) {
                                Image(systemName: AppIconsSF.editIcon)
                            }
                            Button(action: {
                                withAnimation {
                                    showDeleteAlert.toggle()
                                }
                            }) {
                                Image(systemName: AppIconsSF.deleteIcon)
                            }
                        }
                    } else {
                        /*@START_MENU_TOKEN@*/EmptyView()/*@END_MENU_TOKEN@*/
                    }
                }
                .alert(isPresented: $showDeleteAlert) {
                    Alert(title: Text("Delete Article"),
                          message: Text("Are you sure you want to delete this article?"),
                          primaryButton: .destructive(Text("Yes")) {
                        deleteArticle()
                    }, secondaryButton: .cancel())
                }
        )
        .navigationBarTitle(Text(articleViewModal.selectedArticle.title ?? "NA"), displayMode: .inline)
        .navigationDestination(for: CreateArticleScreenType.self) { type in
            let data = type.selectedArticle
            CreateArticleScreen(article: ArticleParams(title: data?.title ?? "", description: data?.description ?? "", body: data?.body ?? "", tagList: data?.tagList ?? []), activeStack: activeStack,slug: articleViewModal.selectedArticle.slug)
        }
        .navigationDestination(for: SelectedProfileScreenType.self){ type in
            SelectedUserScreen(author: type.author, activeStack: activeStack)
        }
        .navigationDestination(for: LoginScreenType.self) { type in
            CreateAccountScreen(screenType: type)
        }
    }
    
    func deleteComment (data: Comment) {
        CommentsServices().deleteComment(
            parameters: nil, endpoint: articleViewModal.selectedArticle.slug! + "/comments/" + "\(data.id!)",
            costumeCompletion: {
                res in
                let statusCode = res?.statusCode
                if (statusCode == 200) {
                    articleViewModal.getComments()
                }
            },completion: {res in
                
            })
    }
    
    func addComment () {
        let postData: [String: Any] = [
            "body": comment
        ]
        let user: [String:Any] = [
            "comment": postData
        ]
        CommentsServices().addComment(
            parameters: user,
            endpoint: articleViewModal.selectedArticle.slug! + "/comments", completion: {
                res in
                switch res {
                case .success(_):
                    articleViewModal.getComments()
                    comment = ""
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
            })
    }
    
    func bookMarkArtie () {
        appViewModel.alertToast = AppMessage.loadingView
        if (articleViewModal.selectedArticle.favorited == true) {
            articleViewModal.removeBookMarkArticle(onComplete: {data, error in
                appViewModel.toggle()
                if ((error) != nil) {
                    appViewModel.errorMessage = error!
                    return
                }
                articleViewModal.updateSelectedArticle(article: data!)
                feedViewModal.updateSelectedFeedArticle(article: data!)
            })
        } else {
            articleViewModal.bookMarkArticle(onComplete: {data, error in
                appViewModel.toggle()
                if ((error) != nil) {
                    appViewModel.errorMessage = error!
                    return
                }
                articleViewModal.updateSelectedArticle(article: data!)
                feedViewModal.updateSelectedFeedArticle(article: data!)
            })
        }
    }
    
    func deleteArticle () {
        ArticleServices().deleteAricle(parameters: nil, endpoint: articleViewModal.selectedArticle.slug ?? ""){
            res in
            switch res {
            case .success(let data):
                if(activeStack == .feed){
                    feedStack.presentedScreen.removeLast()
                    feedViewModal.reloadArticles()
                    return
                }
                if (activeStack == .article){
                    articleStack.presentedScreen.removeLast()
                    articleViewModal.reloadArticles()
                    return
                }
                if (activeStack == .profile){
                    profileStack.presentedScreen.removeLast()
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
    
}


struct ArticleDetailViewScreen_Previews: PreviewProvider {
    
    static var previews: some View {
        NavigationView {
            ArticleDetailViewScreen(activeStack: .article)
        }
        .environmentObject(ArticleViewModel())
        .environmentObject(AuthViewModel())
        .environmentObject(FeedNavigationStackViewModal())
        .environmentObject(TradingNavigationStackViewModal())
        .environmentObject(ProfileNavigationStackViewModal())
        .environmentObject(FeedArticleViewModel())
    }
}
