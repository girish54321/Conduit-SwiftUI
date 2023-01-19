//
//  ArticleDetailViewScreen.swift
//  MyMedium
//
//  Created by neosoft on 18/01/23.
//

import SwiftUI

struct ArticleDetailViewScreen: View {
    
    let article: Article
    @EnvironmentObject var authViewModel: AuthViewModel
    @State var isTheOwner : Bool = false
    
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
                    .animation(.spring(), value: article.title)
                    .padding(.bottom)
                Text(article.title ?? "NA")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.black.opacity(0.5))
                    .cornerRadius(10)
                    .shadow(radius: 10)
                    .transition(.move(edge: .bottom))
                    .animation(.spring(), value: article.title)
                Text(article.body ?? "NA")
                    .padding(.vertical)
                AboutAuthorView(author: article.author)
            }
            .padding()
        }
        .onAppear {
            withAnimation {
                isTheOwner = Helpers.isTheOwner(user: authViewModel.userState?.user, author: article.author)
            }
        }
        .navigationBarItems(
            trailing:
                VStack {
                    if isTheOwner {
                        HStack {
                            Button(action: {
                                // Edit action here
                            }) {
                                Image(systemName: "pencil")
                            }
                            Button(action: {
                                // Edit action here
                            }) {
                                Image(systemName: "trash")
                            }
                        }
                    } else {
                        /*@START_MENU_TOKEN@*/EmptyView()/*@END_MENU_TOKEN@*/
                    }
                }
        )
        .navigationBarTitle(Text(article.title ?? "NA"), displayMode: .inline)
    }
}


struct ArticleDetailViewScreen_Previews: PreviewProvider {
    
    static var previews: some View {
        let data = Article(slug: "", title: "If we quantify the alarm, we can get to the FTP pixel through the online SSL interface!", description: "Omnis perspiciatis qui quia commodi sequi modi. Nostrum quam aut cupiditate est facere omnis possimus. Tenetur similique nemo illo soluta molestias facere quo. Ipsam totam facilis delectus nihil quidem soluta vel est omnis", body: "Quia quo iste et aperiam voluptas consectetur a omnis et.\\nDolores et earum consequuntur sunt et.\\nEa nulla ab voluptatem dicta vel. Temporibus aut adipisci magnam aliquam eveniet nihil laudantium reprehenderit sit.\\nAspernatur cumque labore voluptates mollitia deleniti et. Quos pariatur tenetur.\\nQuasi omnis eveniet eos maiores esse magni possimus blanditiis.\\nQui incidunt sit quos consequa.", tagList: [""], createdAt: "", updatedAt: "", favorited: true, favoritesCount: 2, author: Author(username: "Girish", bio: "My Bios is my bio", image: "", following: true))
        NavigationView {
            ArticleDetailViewScreen(article: data)
        }
    }
}
