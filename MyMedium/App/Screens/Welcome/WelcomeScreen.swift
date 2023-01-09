//
//  WelcomeScreen.swift
//  MyMedium
//
//  Created by neosoft on 09/01/23.
//

import SwiftUI

struct WelcomeScreen: View {
    
    @State private var selection: String? = nil
    @State private var isAnimating: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
//                    Image("bg1")
//                        .resizable()
//                        .ignoresSafeArea()
                    VStack(alignment: .center,spacing: 19)  {
                        VStack(alignment: .leading,spacing: 10) {
                            Text("ReqRes App")
                                .font(.largeTitle)
                                .fontWeight(.heavy)
                                .foregroundColor(Color.blue)
                            Text("Hold the tinsel—the rainbow eucalyptus tree doesn’t need decorations to appear festive for the holidays.")
                                .foregroundColor(Color.white)
                                .font(.footnote)
                        }
                        .padding(.horizontal)
                        Capsule()
                            .frame(height: 2)
                            .foregroundColor(Color.white.opacity(0.5))
                            .padding(.horizontal)
                        VStack (alignment: .center,spacing: 16) {
                            AppButton(
                                text: "Login Up",
                                whiteButton: true,
                                clicked: {
                                  
                                })
                            AppButton(
                                text: "Sign Up",
                                clicked: {
                                   
                                })
                        }
                        .padding(.horizontal)
                    }
                    .offset(x: 0, y: 190)
                
            }
            .opacity(isAnimating ? 1 : 0)
        }
        .onAppear(perform: {
            withAnimation{
                isAnimating = true
            }
        })
    }
}

struct WelcomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeScreen()
    }
}
