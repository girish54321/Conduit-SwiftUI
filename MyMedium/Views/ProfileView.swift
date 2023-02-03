//
//  ProfileView.swift
//  Conduit
//
//  Created by Girish Parate on 23/01/23.
//

import SwiftUI

struct ProfileView: View {
    
    var profileImage: String
    var userName: String
    var bio: String
    var email: String
    
    var clicked: (() -> Void)
    
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
                    Spacer()
                    Button(action: {
                      clicked()
                    }) {
                        Text("Edit")
                    }
                }
                Text(bio)
            }
        }
    }
}
struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(profileImage: "https://media5.bollywoodhungama.in/wp-content/uploads/2021/03/WhatsApp-Image-2021-03-26-at-5.08.26-PM.jpeg", userName: "User Name", bio: "Bio", email: "Email", clicked: {
            
        })
    }
}
