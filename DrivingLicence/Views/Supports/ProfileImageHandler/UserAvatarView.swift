//
//  ShowAvatarView.swift
//  DrivingLicence
//
//  Created by Oğuzhan Can on 1.06.2023.
//

import SwiftUI
import RealmSwift

struct UserAvatarView: View {
    let photo: Photo?
    let online: Bool
    var action: () -> Void = {}
    
    private enum Dimensions {
        static let imageSize: CGFloat = 20
        static let buttonSize: CGFloat = 26
        static let cornerRadius: CGFloat = 40.0
    }
    
    var body: some View {
        Button(action: action) {
            ZStack {
                image
                    .cornerRadius(Dimensions.cornerRadius)
                HStack {
                    Spacer()
                    VStack {
                        Spacer()
                        OnOffCircleView(online: online)
                    }
                }
            }
        }
        .frame(width: Dimensions.buttonSize, height: Dimensions.buttonSize)
    }
    
    var image: some View {
        Group<AnyView> {
            if let image = photo {
                return AnyView(ThumbnailPhotoView(photo: image, imageSize: Dimensions.imageSize))
            } else {
                return AnyView(BlankPersonIconView()
.frame(width: Dimensions.imageSize, height: Dimensions.imageSize))
            }
        }
    }
}

