//
//  ThumbnailWithExpand.swift
//  DrivingLicence
//
//  Created by Oğuzhan Can on 3.06.2023.
//

import SwiftUI

struct ThumbnailWithExpand: View {
    let photo: Photo
    
    @State private var showingFullImage = false
    
    private enum Dimensions {
        static let frameSize: CGFloat = 100
        static let imageSize: CGFloat = 70
        static let buttonSize: CGFloat = 30
        static let radius: CGFloat = 8
        static let buttonPadding: CGFloat = 4
    }
    
    var body: some View {
        VStack {
            Button(action: { showingFullImage = true }) {
                ThumbNailView(photo: photo)
                    .frame(width: Dimensions.imageSize, height: Dimensions.imageSize, alignment: .center)
                    .clipShape(RoundedRectangle(cornerRadius: Dimensions.radius))
            }
            NavigationLink(destination: PhotoFullSizeView(photo: photo), isActive: $showingFullImage) {
                EmptyView()
            }
        }
    }
}
