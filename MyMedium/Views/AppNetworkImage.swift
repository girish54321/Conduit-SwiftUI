//
//  AppNetworkImage.swift
//  MyMedium
//
//  Created by na on 16/01/23.
//

import SwiftUI


struct AppNetworkImage: View {
    var imageUrl: String
    
    var body: some View {
        AsyncImage(url: URL(string: imageUrl), transaction: Transaction(animation: .spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.25))) { phase in
            switch phase {
            case .success(let image):
                image
                    .imageModifier()
                    .transition(.scale)
            case .failure(_):
                Image(systemName: "ant.circle.fill").iconModifier()
            case .empty:
                Image(systemName: "photo.circle.fill").iconModifier()
            @unknown default:
                ProgressView()
            }
        }
    }
}

struct AppNetworkImage_Previews: PreviewProvider {
    static var previews: some View {
        AppNetworkImage(imageUrl: "https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcREYjGkgLJr0d8l2KfRjG7keurmrHL_PeiPeQPCzfURUXXAx5JG").previewLayout(.sizeThatFits)
    }
}
