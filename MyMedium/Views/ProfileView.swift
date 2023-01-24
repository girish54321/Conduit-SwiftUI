//
//  ProfileView.swift
//  MyMedium
//
//  Created by Girish Parate on 23/01/23.
//

import SwiftUI

struct ProfileView: View {
    
    var profileImage: String
    var userName: String
    var bio: String
    var email: String
    
    var body: some View {
        Section {
            VStack(alignment: .leading, spacing: 6) {
                HStack {
                    AppNetworkImage(imageUrl: profileImage)
                        .frame(width: 60, height: 60)
                        .clipShape(
                            RoundedRectangle(cornerRadius: 12)
                        )
                    VStack (alignment: .leading) {
                        Text(userName)
                            .font(.title)
                            .padding(.top)
                            .padding(.bottom,1)
                        Text(email)
                            .foregroundColor(.gray)
                            .padding(.bottom)
                    }
                    .padding(.leading,3)
                }
                Text(bio)
            }
            //            VStack(alignment: .leading) {
            //                AppNetworkImage(imageUrl: profileImage)
            //                            .frame(width: 100, height: 100)
            //                            .clipShape(Circle())
            //                            .overlay(Circle().stroke(Color.white, lineWidth: 4))
            //                            .shadow(radius: 10)
            //                        Text(userName)
            //                            .font(.title)
            //                            .padding(.bottom, 10)
            //                        Text(email)
            //                            .font(.subheadline)
            //                            .foregroundColor(.gray)
            ////                        Spacer()
            //                        Button(action: {
            //                            print("Edit profile tapped!")
            //                        }) {
            //                            Text("Edit Profile")
            //                                .foregroundColor(.white)
            //                                .padding(.vertical, 10)
            //                                .padding(.horizontal, 20)
            //                                .background(Color.blue)
            //                                .cornerRadius(10)
            //                        }
            //                    }.padding()
            //                }
        }
    }
}
struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(profileImage: "https://media5.bollywoodhungama.in/wp-content/uploads/2021/03/WhatsApp-Image-2021-03-26-at-5.08.26-PM.jpeg", userName: "User Name", bio: "Bio", email: "Email")
    }
}
