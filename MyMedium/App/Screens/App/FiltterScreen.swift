//
//  Filtter.swift
//  MyMedium
//
//  Created by neosoft on 20/01/23.
//

import SwiftUI

struct FiltterScreen: View {
    @State private var selectedOption = -1
    let options = ["Option 1", "Option 2", "Option 3"]
    @State private var someBool : Bool = false
    @State private var searchText = ""
    
    @EnvironmentObject var articleViewModel: ArticleViewModel
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Search By User")) {
                    TextField("Search for a user...",
                              text: $articleViewModel.filtterParameters.author.toUnwrapped(defaultValue: "")
                    )
                }
                Section(header: Text("Search by tag")) {
                    if articleViewModel.tagList?.tags?.count ?? 0 > 1 {
                        Picker(selection: $selectedOption, label: Text("Tags"), content: {
                            ForEach(0 ..< (articleViewModel.tagList?.tags!.count)!) { index in
                                Text((self.articleViewModel.tagList?.tags![index])!.capitalized).tag(index)
                                    .lineLimit(1)
                            }
                        })
                        .onChange(of: selectedOption, perform: { newValue in
                            articleViewModel.filtterParameters.tag = self.articleViewModel.tagList?.tags![selectedOption]
                        })
                    } else {
                        /*@START_MENU_TOKEN@*/EmptyView()/*@END_MENU_TOKEN@*/
                    }
                }
                if authViewModel.isLogedin {
                    Section(header: Text("my booksmarks only")) {
                        Toggle(isOn: $someBool) {
                            Text("Saved")
                        }
                        .onChange(of: someBool, perform: {newValue in
                            if (someBool) {
                                articleViewModel.filtterParameters.favorited = authViewModel.isLogedin ? authViewModel.userState?.user?.username : ""
                            }
                        })
                    }
                } else {
                    /*@START_MENU_TOKEN@*/EmptyView()/*@END_MENU_TOKEN@*/
                }
                Section {
                    Button("Apply") {
                        articleViewModel.showFiltterScreen.toggle()
                        articleViewModel.getArticles()
                    }
                    Button("Clear",role: .destructive) {
                        articleViewModel.createFiltter()
                        articleViewModel.showFiltterScreen.toggle()
                    }
                }
                Section {
                    
                }
            }
            .navigationBarTitle("Filter")
            .navigationBarItems(
                trailing:
                    Button(action: {
                        articleViewModel.showFiltterScreen.toggle()
                    }) {
                        Image(systemName: AppIconsSF.closeIcon)
                    }            )
        }
    }
    
    
}

struct Filtter_Previews: PreviewProvider {
    static var previews: some View {
        FiltterScreen()
            .environmentObject(ArticleViewModel())
            .environmentObject(AuthViewModel())
    }
}
