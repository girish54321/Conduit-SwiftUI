//
//  ChipView.swift
//  MyMedium
//
//  Created by neosoft on 16/01/23.
//

import SwiftUI

struct ChipView: View {
    var title: String
    var body: some View {
        HStack {
            Text(title)
                .font(.caption)
                .foregroundColor(.white)
                .padding(6)
        }
        .background(Color.blue)
        .cornerRadius(20)
        .padding(.top,4)
    }
}

struct ChipView_Previews: PreviewProvider {
    static var previews: some View {
        ChipView(title: "Chips")
    }
}
