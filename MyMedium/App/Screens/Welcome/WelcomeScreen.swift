//
//  WelcomeScreen.swift
//  Conduit
//
//  Created by na on 09/01/23.
//

import SwiftUI
import AlertToast

struct WelcomeScreen: View {
    
    @State private var selection: String? = nil
    @State private var isAnimating: Bool = false
    @State private var animationAmount = 1.0
    @State private var presentedScreen = NavigationPath()
    @EnvironmentObject var appViewModel: AppViewModel
    
    @AppStorage(AppConst.isSkipped) var isSkipped: Bool = false
    @AppStorage(AppConst.token) var token: String = ""
    
    var body: some View {
        NavigationStack (path: $presentedScreen) {
            VStack {
                Image(uiImage: UIImage(imageLiteralResourceName: "AppIcon"))
                    .imageModifier()
                    .frame(width: 150,height: 150)
                    .padding()
                    .overlay(
                        Circle()
                            .stroke(Color.accentColor)
                            .scaleEffect(animationAmount)
                            .opacity(2 - animationAmount)
                            .animation(
                                .easeInOut(duration: 1)
                                .repeatForever(autoreverses: false),
                                value: animationAmount
                            )
                    )
                    .onAppear {
                        withAnimation {
                            animationAmount = 2
                        }
                    }
                VStack(alignment: .center,spacing: 19)  {
                    VStack(alignment: .leading,spacing: 10) {
                        HStack {
                            Text("Conduit")
                                .font(.largeTitle)
                                .fontWeight(.heavy)
                                .foregroundColor(Color.accentColor)
                            Spacer()
                        }
                        Text("Conduit \nMother of all demo App")
                            .foregroundColor(Color.gray)
                            .font(.footnote)
                    }
                    .padding(.horizontal)
                    Capsule()
                        .frame(height: 2)
                        .foregroundColor(Color.accentColor.opacity(0.5))
                        .padding(.horizontal)
                    VStack (alignment: .center,spacing: 16) {
                        AppButton(
                            text: "Login",
                            clicked: {
                                let data = LoginScreenType(title: "Welcome Back", isCreateAccount: false)
                                presentedScreen.append(data)
                            })
                        AppButton(
                            text: "Sign Up",
                            clicked: {
                                let data = LoginScreenType(title: "Let's Start", isCreateAccount: true)
                                presentedScreen.append(data)
                            })
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 140)
                }
                .offset(x: 0, y: 190)
            }
            .opacity(isAnimating ? 1 : 0)
            .navigationDestination(for: LoginScreenType.self) { type in
                CreateAccountScreen(screenType: type)
            }
            .navigationBarItems(
                trailing:
                    SkipButton(clicked: {
                        isSkipped = true
                    })
            )
            .navigationBarTitleDisplayMode(.large)
        }
        .onAppear(perform: {
            withAnimation {
                isAnimating = true
            }
        })
        .toast(isPresenting: $appViewModel.show){
            appViewModel.alertToast
        }
        .alert(isPresented: $appViewModel.showAlert) { () -> Alert in
            Alert(title: Text("Error"), message: Text(appViewModel.errorMessage))
        }
        .safeAreaInset(edge: .bottom) {
        }
    }
}

struct WelcomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeScreen()
            .environmentObject(AppViewModel())
    }
}
