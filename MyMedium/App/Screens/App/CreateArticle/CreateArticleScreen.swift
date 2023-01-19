//
//  CreateArticleScreen.swift
//  MyMedium
//
//  Created by neosoft on 17/01/23.
//

import SwiftUI
import AlertToast

struct CreateArticleScreen: View {

    @State var article = ArticleParams(title: "", description: "", body: "", tagList: [])
    
    @EnvironmentObject var appViewModel: AppViewModel
    
    var body: some View {
        NavigationView {
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
                Spacer()
                AppButton(text: "Save", clicked: {
                    uploadAricle()
                })
                HStack {
                    ForEach(article.tagList ?? [], id: \.self) { data in
                        ChipView(title: data)
                    }
                }
                .padding(.top)
            }
            .padding()
            .navigationTitle("Create Article")
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
//        title = ""
//        description = ""
//        bodyText = ""
    }
}

struct CreateArticleScreen_Previews: PreviewProvider {
    static var previews: some View {
        CreateArticleScreen()
            .environmentObject(AppViewModel())
    }
}
