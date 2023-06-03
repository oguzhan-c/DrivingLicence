//
//  ThumbnailPhotoView.swift
//  DrivingLicence
//
//  Created by Oğuzhan Can on 1.06.2023.
//

import SwiftUI

struct ThumbnailPhotoView: View {
    let photo: Photo
    var imageSize: CGFloat = 64
    
    var body: some View {
        if let photo = photo.thumbNail {
            let mugShot = UIImage(data: photo)
            Image(uiImage: mugShot ?? UIImage())
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: imageSize, height: imageSize)
        }
    }
}
