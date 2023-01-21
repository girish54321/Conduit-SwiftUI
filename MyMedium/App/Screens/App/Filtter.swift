//
//  Filtter.swift
//  MyMedium
//
//  Created by neosoft on 20/01/23.
//

import SwiftUI

struct Filtter: View {
    @State private var selectedOption = 0
    let options = ["Option 1", "Option 2", "Option 3"]
    @State private var someBool : Bool = true
    @State private var tagList: ArticleTag? = nil
    @State private var searchText = ""

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Search By User")) {
                    TextField("Search for a user...", text: $searchText)
                }
                Section(header: Text("Search by tag")) {
                    if tagList?.tags?.count ?? 0 > 1 {
                        Picker(selection: $selectedOption, label: Text("Tags"), content: {
                            ForEach(0 ..< (tagList?.tags!.count)!) { index in
                                Text((self.tagList?.tags![index])!.capitalized).tag(index)
                            }
                        })

                    } else {
                        /*@START_MENU_TOKEN@*/EmptyView()/*@END_MENU_TOKEN@*/
                    }
                }
                Section(header: Text("my booksmarks only")) {
                    Toggle(isOn: $someBool) {
                        Text("Saved")
                    }
                }
                Section {
                    Button("Apply") {
                        getTags()
                    }
                }
            }.navigationBarTitle("Filter")
        }
    }
    
    func getTags() {
        ArticleServices().getTags(parameters: nil){
            result in
            switch result {
            case .success(let data):
                withAnimation {
                    tagList = data
                }
                
                print(data.tags?[0])
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

struct Filtter_Previews: PreviewProvider {
    static var previews: some View {
        Filtter()
    }
}
