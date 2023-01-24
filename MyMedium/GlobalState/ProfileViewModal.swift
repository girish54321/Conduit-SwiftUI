//
//  ProfileViewModal.swift
//  MyMedium
//
//  Created by Girish Parate on 24/01/23.
//

import Foundation
class ProfileViewModel: ObservableObject {
    
    @Published var selectedAuther: Author = DummyData().autherData
    @Published var selectedUserArticle: TrandingArticles? = nil
    @Published var isLoading: Bool = false
    
    
    func getSelectedAutherArticle(parameters: ArticleListParams) {
        isLoading = true
        ArticleServices().getTrandingArticle(parameters: parameters.toDictionary()){
            result in
            switch result {
            case .success(let data):
                self.selectedUserArticle = data
                self.isLoading = false
            case .failure(let error):
                self.isLoading = false
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
