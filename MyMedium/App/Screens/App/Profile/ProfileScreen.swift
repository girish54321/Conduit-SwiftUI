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
    
    var body: some View {
        NavigationView {
            List {
                Section ("Hello") {
                    VStack(alignment: .leading, spacing: 6) {
                        AppNetworkImage(imageUrl: authViewModel.userState?.user?.image ?? "https://media5.bollywoodhungama.in/wp-content/uploads/2021/03/WhatsApp-Image-2021-03-26-at-5.08.26-PM.jpeg")
                            .frame(width: 60, height: 60)
                            .clipShape(
                                RoundedRectangle(cornerRadius: 12)
                            )
                        Text(authViewModel.userState?.user?.username ?? "username")
                            .font(.title)
                        Text(authViewModel.userState?.user?.bio ?? "Bio")
                            .padding(.top,1)
                        Text(authViewModel.userState?.user?.email ?? "Email")
                            .foregroundColor(.gray)
                            .padding(.top,3)
                    }
                }
                .onAppear {
                    authViewModel.getArticles(parameters: ArticleListParams(author:authViewModel.userState?.user?.username,limit: "50"))
                }
                Section ("your articles") {
                    ForEach(authViewModel.userArticle?.articles ?? []) { data in
                        VStack {
                            HStack {
                                ArticleRow(article: data)
                                    .padding(.bottom)
                                Spacer()
                            }
                            Divider()
                        }
                    }
                    .alert(isPresented: $showLogOutAlert) {
                        Alert(title: Text("Log out?"),
                              message: Text("Are you sure you want to delete this article?"),
                              primaryButton: .destructive(Text("Yes")) {
                            authViewModel.userState = nil
                            authViewModel.tokan = ""
                            authViewModel.isLogedin = false
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
                    .navigationBarTitle("Profile")
                }
            }
            .refreshable {
                authViewModel.getProfile()
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
