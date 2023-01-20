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
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Select an option:")) {
                    if tagList?.tags?.count ?? 0 > 0 {
                        Picker("Select an option:", selection: $selectedOption) {
                            ForEach(0 ..< (tagList?.tags!.count)!) {
                                Text(self.options[$0])
                            }
                        }
                    } else {
                        /*@START_MENU_TOKEN@*/EmptyView()/*@END_MENU_TOKEN@*/
                    }
                }
                Section(header: Text("Filter by")) {
                    Toggle(isOn: $someBool) {
                        Text("Some toggle")
                    }
                    Toggle(isOn: $someBool) {
                        Text("Some toggle")
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
