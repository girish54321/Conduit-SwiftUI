//
//  ArticleDetailViewScreen.swift
//  MyMedium
//
//  Created by neosoft on 18/01/23.
//

import SwiftUI
import AlertToast

struct ArticleDetailViewScreen: View {
    
    @EnvironmentObject var articleViewModal: ArticleViewModel
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var feedStack: FeedNavigationStackViewModal
    @EnvironmentObject var articleStack: TrandingNavigationStackViewModal
    @EnvironmentObject var profileStack: ProfileNavigationStackViewModal
    @EnvironmentObject var feedViewModal: FeedArticleViewModel
    @State private var showDeleteAlert = false
    @EnvironmentObject var appViewModel: AppViewModel
    @State var isTheOwner : Bool = false
    @State var comments: CommentListResponse?
    @State var activeStack: AppNavStackType
    
    @State private var comment: String = ""
    
    var body: some View {
        ScrollView {
            VStack {
                //                AppNetworkImage(imageUrl: "https://picsum.photos/300")
                //                    .frame(minWidth: 0, maxWidth: .infinity)
                //                    .aspectRatio(contentMode: .fill)
                //                    .clipped()
                //                    .cornerRadius(10)
                //                    .shadow(radius: 10)
                //                    .transition(.move(edge: .bottom))
                //                    .animation(.spring(), value: articleViewModal.selectedArticle.title)
                //                    .padding(.bottom)
                //                Text(articleViewModal.selectedArticle.title ?? "NA")
                //                    .foregroundColor(.white)
                //                    .padding()
                //                    .background(Color.black.opacity(0.5))
                //                    .cornerRadius(10)
                //                    .shadow(radius: 10)
                //                    .transition(.move(edge: .bottom))
                //                    .animation(.spring(), value: articleViewModal.selectedArticle.title)
                //                Text(articleViewModal.selectedArticle.body ?? "NA")
                //                    .padding(.vertical)
                //                ScrollView(.horizontal, showsIndicators: false) {
                //                    HStack {
                //                        ForEach(articleViewModal.selectedArticle.tagList ?? [], id: \.self) { data in
                //                            ChipView(title: data)
                //                        }
                //                    }
                //                }
                //                .padding(.bottom)
                HStack {
                    Text(Helpers.formatDateFormat(dateString: articleViewModal.selectedArticle.createdAt ?? ""))
                    Spacer()
                    Button(action: {
                        appViewModel.alertToast = AppMessage.loadindView
                        if (articleViewModal.selectedArticle.favorited == true) {
                            articleViewModal.removeBookMarkArticle(onComple: {data, error in
                                appViewModel.toggle()
                                if ((error) != nil) {
                                    appViewModel.errorMessage = error!
                                    return
                                }
                                articleViewModal.updateSelectedArticle(article: data!)
                                feedViewModal.updateSelectedFeedArticle(article: data!)
                            })
                        } else {
                            articleViewModal.bookMarkArticle(onComple: {data, error in
                                appViewModel.toggle()
                                if ((error) != nil) {
                                    appViewModel.errorMessage = error!
                                    return
                                }
                                articleViewModal.updateSelectedArticle(article: data!)
                                feedViewModal.updateSelectedFeedArticle(article: data!)
                            })
                        }
                    }) {
                        Image(systemName: articleViewModal.selectedArticle.favorited ?? false ? AppIconsSF.bookMarkFillIcon : AppIconsSF.bookMarkIcon)
                            .frame(width: 30,height: 30)
                    }
                    .frame(width: 30,height: 30)
                }
                AboutAuthorView(author: articleViewModal.selectedArticle.author)
                    .onTapGesture {
                        let data = SelectedProfileScreenType(auther: articleViewModal.selectedArticle.author!)
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
                AppInputBox(placeHoldr: "Add You Coments",
                            keyboard: AppKeyBoardType.default, value: $comment)
                Button(action: {
                    
                }) {
                    VStack {
                        Spacer()
                        Text("Post")
                            .padding()
                    }
                }
            }
            .padding()
        }
        .onAppear {
            withAnimation {
                isTheOwner = Helpers.isTheOwner(user: authViewModel.userState?.user, author: articleViewModal.selectedArticle.author)
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
        )
        .alert(isPresented: $showDeleteAlert) {
            Alert(title: Text("Delete Article"),
                  message: Text("Are you sure you want to delete this article?"),
                  primaryButton: .destructive(Text("Yes")) {
                deleteArticle()
            }, secondaryButton: .cancel())
        }
        .navigationDestination(for: CreateArticleScreenType.self) { type in
            let data = type.selectedArticle
            CreateArticleScreen(article: ArticleParams(title: data?.title ?? "", description: data?.description ?? "", body: data?.body ?? "", tagList: data?.tagList ?? []), activeStack: activeStack,slug: articleViewModal.selectedArticle.slug)
        }
        .navigationDestination(for: SelectedProfileScreenType.self){ type in
            SelectedUserScreen(auther: type.auther, activeStack: activeStack)
        }
        .navigationBarTitle(Text(articleViewModal.selectedArticle.title ?? "NA"), displayMode: .inline)
    }
    
    func deleteArticle () {
        ArticleServices().deleteAricle(parameters: nil, endpoint: articleViewModal.selectedArticle.slug ?? ""){
            res in
            switch res {
            case .success(let data):
                print("remove bookmar")
                if(activeStack == .feed){
                    feedStack.presentedScreen.removeLast()
                    return
                }
                if (activeStack == .article){
                    articleStack.presentedScreen.removeLast()
                    return
                }
                if (activeStack == .profile){
                    profileStack.presentedScreen.removeLast()
                }
                print(data)
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
    
}


struct ArticleDetailViewScreen_Previews: PreviewProvider {
    
    static var previews: some View {
        NavigationView {
            ArticleDetailViewScreen(activeStack: .article)
        }
        .environmentObject(ArticleViewModel())
        .environmentObject(AuthViewModel())
        .environmentObject(FeedNavigationStackViewModal())
        .environmentObject(TrandingNavigationStackViewModal())
        .environmentObject(ProfileNavigationStackViewModal())
        .environmentObject(FeedArticleViewModel())
    }
}
