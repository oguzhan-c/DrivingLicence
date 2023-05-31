//
//  ThumbNailView.swift
//  DrivingLicence
//
//  Created by Oğuzhan Can on 31.05.2023.
//

import SwiftUI

struct ThumbNailView: View {
    let photo: Photo?
    private let compressionQuality: CGFloat = 0.8
    
    var body: some View {
        VStack {
            if let photo = photo {
                if photo.thumbNail != nil || photo.picture != nil {
                    if let photo = photo.thumbNail {
                        Thumbnail(imageData: photo)
                    } else {
                        if let photo = photo.picture {
                            Thumbnail(imageData: photo)
                        } else {
                            Thumbnail(imageData: UIImage().jpegData(compressionQuality: compressionQuality)!)
                        }
                    }
                }
            }
        }
    }
}
