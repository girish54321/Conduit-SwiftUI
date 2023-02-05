//
//  DemoScreen.swift
//  MyMedium
//
//  Created by Girish Parate on 05/02/23.
//

import SwiftUI


struct EndReachedKey: PreferenceKey {
    static var defaultValue: [CGFloat] = []
    
    static func reduce(value: inout [CGFloat], nextValue: () -> [CGFloat]) {
        value.append(contentsOf: nextValue())
    }
}

struct DemoScreen: View {
   
    
    var body: some View {
        GeometryReader { geometry in
            List {
                LazyVStack{
                    ForEach([DummyData().data,DummyData().data,DummyData().data,DummyData().data,DummyData().data,DummyData().data,DummyData().data,DummyData().data,DummyData().data,DummyData().data,DummyData().data]) { article in
                        //                    Text("article.title")
                        ArticleRow(article: article)
                    }
                    .background(GeometryReader { geo in
                        Color.clear.preference(key: EndReachedKey.self, value: [geo.frame(in: .global).maxY])
                    })
                }
            }
            .onPreferenceChange(EndReachedKey.self) { value in
                if let maxY = value.last {
                    if maxY < geometry.frame(in: .global).maxY {
                        print("End reached")
                    }
                }
            }
        }
    }
}

//struct Article {
//    let title: String
//}


struct DemoScreen_Previews: PreviewProvider {
    static var previews: some View {
        DemoScreen()
    }
}
