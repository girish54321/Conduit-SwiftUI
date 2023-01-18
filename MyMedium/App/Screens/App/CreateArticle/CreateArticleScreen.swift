//
//  CreateArticleScreen.swift
//  MyMedium
//
//  Created by neosoft on 17/01/23.
//

import SwiftUI

struct CreateArticleScreen: View {
    
    @State private var title: String = ""
    @State private var description: String = ""
    @State private var bodyText: String = ""
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                AppInputBox(
                    placeHoldr: "Enter title here",
                    keyboard: AppKeyBoardType.default,
                    title:"Title", value: $title
                )
                AppInputBox(
                    placeHoldr: "Enter description here",
                    keyboard: AppKeyBoardType.default,
                    title:"Description", value: $description
                )
                Text("Body").font(.headline)
                TextEditor(text: $bodyText)
                    .frame(height: 200)
                    .border(Color.gray)
//                TextEditor(text: $bodyText)
                    
                Spacer()
                AppButton(text: "Save", clicked: {
                    
                })
                .padding(.top)
            }
            .padding()
            .navigationTitle("Create Article")
        }
    }
}

struct CreateArticleScreen_Previews: PreviewProvider {
    static var previews: some View {
        CreateArticleScreen()
    }
}
