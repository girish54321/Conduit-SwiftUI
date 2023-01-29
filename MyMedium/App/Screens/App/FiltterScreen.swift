//
//  Flitter.swift
//  MyMedium
//
//  Created by NA on 20/01/23.
//

import SwiftUI

struct FlitterScreen: View {
    @State private var selectedOption = -1
    let options = ["Option 1", "Option 2", "Option 3"]
    @State private var searchText = ""
    
    @EnvironmentObject var articleViewModel: ArticleViewModel
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var someBool : Bool = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Search By User")) {
                    TextField("Search for a user...",
                              text: $articleViewModel.flitterParameters.author.toUnwrapped(defaultValue: "")
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
                            articleViewModel.flitterParameters.tag = self.articleViewModel.tagList?.tags![selectedOption]
                        })
                    } else {
                        /*@START_MENU_TOKEN@*/EmptyView()/*@END_MENU_TOKEN@*/
                    }
                }
                if authViewModel.isLoggedIn {
                    Section(header: Text("my bookmarks only")) {
                        Toggle(isOn: $someBool) {
                            Text("Saved")
                        }
                        .onChange(of: someBool, perform: {newValue in
                            if (someBool) {
                                articleViewModel.flitterParameters.favorite = authViewModel.isLoggedIn ? authViewModel.userState?.user?.username : ""
                            }
                        })
                    }
                } else {
                    /*@START_MENU_TOKEN@*/EmptyView()/*@END_MENU_TOKEN@*/
                }
                Section {
                    Button("Apply") {
                        articleViewModel.showFlitterScreen.toggle()
                        articleViewModel.getArticles()
                    }
                    Button("Clear",role: .destructive) {
                        articleViewModel.createFlitter()
                        articleViewModel.showFlitterScreen.toggle()
                    }
                }
                Section {
                    
                }
            }
            .onAppear {
                if(articleViewModel.flitterParameters.favorite == nil) {
                    return
                }
                someBool = (articleViewModel.flitterParameters.favorite != nil)
            }
            .navigationBarTitle("Filter")
            .navigationBarItems(
                trailing:
                    Button(action: {
                        articleViewModel.showFlitterScreen.toggle()
                    }) {
                        Image(systemName: AppIconsSF.closeIcon)
                    }            )
        }
    }
    
    
}

struct Flitter_Previews: PreviewProvider {
    static var previews: some View {
        FlitterScreen()
            .environmentObject(ArticleViewModel())
            .environmentObject(AuthViewModel())
    }
}
