//
//  WelcomeScreen.swift
//  MyMedium
//
//  Created by neosoft on 09/01/23.
//

import SwiftUI
import AlertToast

struct WelcomeScreen: View {
    
    @State private var selection: String? = nil
    @State private var isAnimating: Bool = false
    @State private var animationAmount = 1.0
    @State private var presentedNumbers = NavigationPath()
    @EnvironmentObject var appViewModel: AppViewModel
    
    @AppStorage(AppConst.isSkiped) var isSkiped: Bool = false
    @AppStorage(AppConst.tokan) var tokan: String = ""
    
    var body: some View {
        NavigationStack (path: $presentedNumbers) {
            VStack {
                Image(systemName: "keyboard")
                    .imageModifier()
                    .frame(width: 120,height: 120)
                    .padding()
                    .overlay(
                        Circle()
                            .stroke(.blue)
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
                            Text("Medium Clone")
                                .font(.largeTitle)
                                .fontWeight(.heavy)
                                .foregroundColor(Color.blue)
                            Spacer()
                        }
                        Text("Medium Clone \nMother of all demo App")
                            .foregroundColor(Color.gray)
                            .font(.footnote)
                    }
                    .padding(.horizontal)
                    Capsule()
                        .frame(height: 2)
                        .foregroundColor(Color.blue.opacity(0.5))
                        .padding(.horizontal)
                    VStack (alignment: .center,spacing: 16) {
                        AppButton(
                            text: "Login",
                            whiteButton: true,
                            clicked: {
                                let data = LoginScreenType(title: "Welcome Back", isCreateAccount: false)
                                presentedNumbers.append(data)
                            })
                        AppButton(
                            text: "Sign Up",
                            clicked: {
                                let data = LoginScreenType(title: "Let's Start", isCreateAccount: true)
                                presentedNumbers.append(data)
                            })
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 140)
                }
                .offset(x: 0, y: 190)
            }
            .opacity(isAnimating ? 1 : 0)
            .navigationDestination(for: LoginScreenType.self) { type in
                CreateAccountScreen(screnType: type)
            }
            .navigationBarItems(
                trailing:
                    SkipButton(clicked: {
                        isSkiped = true
                    })
            )
            .navigationBarTitleDisplayMode(.large)
        }
        .onAppear(perform: {
            withAnimation{
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
//                Text("Outside Safe Area")
//                    .font(.largeTitle)
//                    .foregroundColor(.white)
//                    .frame(maxWidth: .infinity)
//                    .padding()
//                    .background(.indigo)
            }
    }
}

struct WelcomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeScreen()
            .environmentObject(AppViewModel())
    }
}
