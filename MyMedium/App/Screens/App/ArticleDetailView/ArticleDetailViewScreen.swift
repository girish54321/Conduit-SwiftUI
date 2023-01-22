//
//  ArticleDetailViewScreen.swift
//  MyMedium
//
//  Created by neosoft on 18/01/23.
//

import SwiftUI
import AlertToast

struct ArticleDetailViewScreen: View {
    
//    @State var article: Article
    @EnvironmentObject var articleViewModal: ArticleViewModel
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var navStack: FeedNavigationStackViewModal
    @EnvironmentObject var navStack2: TrandingNavigationStackViewModal
    @State var isTheOwner : Bool = false
    @State var isFeedStack: Bool = false
    @State private var showDeleteAlert = false
    @EnvironmentObject var appViewModel: AppViewModel
    
    var body: some View {
        ScrollView {
            VStack {
                AppNetworkImage(imageUrl: "https://picsum.photos/300")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .aspectRatio(contentMode: .fill)
                    .clipped()
                    .cornerRadius(10)
                    .shadow(radius: 10)
                    .transition(.move(edge: .bottom))
                    .animation(.spring(), value: articleViewModal.selectedArticle.title)
                    .padding(.bottom)
                Text(articleViewModal.selectedArticle.title ?? "NA")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.black.opacity(0.5))
                    .cornerRadius(10)
                    .shadow(radius: 10)
                    .transition(.move(edge: .bottom))
                    .animation(.spring(), value: articleViewModal.selectedArticle.title)
                Text(articleViewModal.selectedArticle.body ?? "NA")
                    .padding(.vertical)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(articleViewModal.selectedArticle.tagList ?? [], id: \.self) { data in
                            ChipView(title: data)
                        }
                    }
                }
                .padding(.bottom)
                HStack {
                    Text(Helpers.formatDateFormat(dateString: articleViewModal.selectedArticle.createdAt ?? ""))
                    Spacer()
                    Button(action: {
                        if (articleViewModal.selectedArticle.favorited == true){
                            articleViewModal.removeBookMarkArticle(appViewModel: appViewModel)
                        } else {
                            articleViewModal.bookMarkArticle(appViewModel: appViewModel)
                        }
                    }) {
                        Image(systemName: articleViewModal.selectedArticle.favorited ?? false ? AppIconsSF.bookMarkFillIcon : AppIconsSF.bookMarkIcon)
                            .frame(width: 30,height: 30)
                    }
                    .frame(width: 30,height: 30)
                }
                AboutAuthorView(author: articleViewModal.selectedArticle.author)
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
                                if (!isFeedStack){
                                    navStack2.presentedScreen.append(data)
                                    return
                                }
                                navStack.presentedScreen.append(data)
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
            CreateArticleScreen(article: ArticleParams(title: data?.title ?? "", description: data?.description ?? "", body: data?.body ?? "", tagList: data?.tagList ?? []),slug: articleViewModal.selectedArticle.slug)
        }
        .navigationBarTitle(Text(articleViewModal.selectedArticle.title ?? "NA"), displayMode: .inline)
    }
    
    func deleteArticle () {
        ArticleServices().deleteAricle(parameters: nil, endpoint: articleViewModal.selectedArticle.slug ?? ""){
            res in
            switch res {
            case .success(let data):
                print("remove bookmar")
                appViewModel.alertToast = AlertToast(displayMode: .banner(.slide), type: .complete(.green), title: "Article Delete!")
                if (!isFeedStack){
                    navStack2.presentedScreen.removeLast()
                    return
                }
                navStack.presentedScreen.removeLast()
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
            ArticleDetailViewScreen()
        }
        .environmentObject(FeedNavigationStackViewModal())
        .environmentObject(AuthViewModel())
        .environmentObject(AppViewModel())
    }
}
