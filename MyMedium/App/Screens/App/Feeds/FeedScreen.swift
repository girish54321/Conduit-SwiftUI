//
//  FeedScreen.swift
//  MyMedium
//
//  Created by neosoft on 17/01/23.
//

import SwiftUI

struct FeedScreen: View {
    
    @State var articleData: FeedArticle? = nil
    @EnvironmentObject var navStack: FeedNavigationStackViewModal
    @EnvironmentObject var authViewModel: AuthViewModel
    
    @State private var showBottomSheet = false
    
    var body: some View {
        NavigationStack (path: $navStack.presentedScreen) {
            List(articleData?.articles ?? []) { article in
                Button (action: {
                    let data = SelectedArticleScreenType(selectedArticle: article)
                    navStack.presentedScreen.append(data)
                }, label: {
                    HStack {
                        ArticleRow(article: article)
                    }
                })
                .buttonStyle(.plain)
            }
            .navigationBarItems(
                trailing:
                    Button(action: {
                        showBottomSheet.toggle()
                    }) {
                        Image(systemName: AppIconsSF.editIcon)
                    }            )
            .sheet(isPresented: $showBottomSheet, content: {
                Filtter()
            })
            .navigationDestination(for: SelectedArticleScreenType.self) { type in
                ArticleDetailViewScreen(article: type.selectedArticle!,isFeedStack: true)
            }
            .navigationBarTitle("Feed")
        }
        .onAppear {
            //            getUserList()
            //            getProfile()
        }
    }
    
    func getProfile() {
        AuthServices().getUser(parameters: nil){
            result in
            switch result {
            case .success(let data):
                authViewModel.userState = data
            case .failure(let error):
                switch error {
                case .NetworkErrorAPIError(let errorMessage):
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
    
    func getUserList() {
        print("Dping API call")
        let parameters: [String: Any] = [
            "limit":"5",
        ]
        ArticleServices().getFeedArticle(parameters: parameters){
            result in
            switch result {
            case .success(let data):
                withAnimation {
                    articleData = data
                }
            case .failure(let error):
                switch error {
                case .NetworkErrorAPIError(let errorMessage):
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

struct FeedScreen_Previews: PreviewProvider {
    static var previews: some View {
        FeedScreen()
            .environmentObject(FeedNavigationStackViewModal())
            .environmentObject(AuthViewModel())
    }
}
