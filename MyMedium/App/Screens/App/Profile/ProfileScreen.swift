//
//  ProfileScreen.swift
//  MyMedium
//
//  Created by neosoft on 17/01/23.
//

import SwiftUI

struct ProfileScreen: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @AppStorage(AppConst.isSkiped) var isSkiped: Bool = false
    @AppStorage(AppConst.tokan) var tokan: String = ""
    @State private var showLogOutAlert = false
    @State var articleData: TrandingArticles? = nil
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .center, spacing:3) {
                    AppNetworkImage(imageUrl: authViewModel.userState?.user?.image ?? "")
                        .frame(width: 120, height: 120)
                        .clipShape(
                            RoundedRectangle(cornerRadius: 12)
                        )
                    Text(authViewModel.userState?.user?.username ?? "username")
                        .font(.title)
                        .padding(.top)
                    Text(authViewModel.userState?.user?.bio ?? "Bio")
                        .padding(.top,1)
                    Text(authViewModel.userState?.user?.email ?? "Email")
                        .foregroundColor(.gray)
                        .padding(.top,3)
                }
                ForEach(articleData?.articles ?? []) { data in
                    HStack {
                        ArticleRow(article: data)
                        Spacer()
                    }
                }
                .padding()
                .alert(isPresented: $showLogOutAlert) {
                    Alert(title: Text("Log out?"),
                          message: Text("Are you sure you want to delete this article?"),
                          primaryButton: .destructive(Text("Yes")) {
                        authViewModel.userState = nil
                        authViewModel.tokan = ""
                        isSkiped = false
                        tokan = ""
                    }, secondaryButton: .cancel())
                }
                .navigationBarItems(
                    trailing:
                        Button(action: {
                            showLogOutAlert.toggle()
                        }) {
                            Text("Logout")
                        }
                )
                .onAppear {
                    getUserList()
                }
                .navigationBarTitle("Profile")
            }
        }
    }
    
    func getUserList() {
        print("Dping API call")
        let parameters: [String: Any] = [
            "limit":"50",
            "author":authViewModel.userState?.user?.username ?? ""
        ]
        ArticleServices().getTrandingArticle(parameters: parameters){
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


struct ProfileScreen_Previews: PreviewProvider {
    static var previews: some View {
        ProfileScreen()
            .environmentObject(AuthViewModel()
            )
    }
}
