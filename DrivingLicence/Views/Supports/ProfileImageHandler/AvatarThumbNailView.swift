//
//  AvatarThumbNailView.swift
//  DrivingLicence
//
//  Created by Oğuzhan Can on 31.05.2023.
//

import SwiftUI

struct AvatarThumbNailView: View {
    let photo: Photo
    var imageSize: CGFloat = 102

    private enum Dimensions {
        static let radius: CGFloat = 4
        static let iconPadding: CGFloat = 8
        static let compressionQuality: CGFloat = 0.8
    }

    var body: some View {
        VStack {
            if let photo = photo {
                ThumbNailView(photo: photo)
            } else {
                if let photo = photo.picture {
                    Thumbnail(imageData: photo)
                } else {
                    Thumbnail(imageData: UIImage().jpegData(compressionQuality: Dimensions.compressionQuality)!)
                }
            }
        }
        .frame(width: imageSize, height: imageSize)
        .background(Color.gray)
        .cornerRadius(Dimensions.radius)
        .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
    }
}

