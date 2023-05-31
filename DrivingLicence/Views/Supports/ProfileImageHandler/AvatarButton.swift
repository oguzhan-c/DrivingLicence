//
//  AvatarButton.swift
//  DrivingLicence
//
//  Created by Oğuzhan Can on 31.05.2023.
//

import SwiftUI

struct AvatarButton: View {
    let photo: Photo
    let action: () -> Void
    
    private enum Dimensions {
        static let frameWidth: CGFloat = 40
        static let frameHeight: CGFloat = 30
        static let opacity = 0.9
    }
    
    var body: some View {
        ZStack {
            Button(action: action) {
                AvatarThumbNailView(photo: photo)
            }
            Image(systemName: "camera.fill")
                .resizable()
                .frame(width: Dimensions.frameWidth, height: Dimensions.frameHeight)
                .foregroundColor(.gray)
                .opacity(Dimensions.opacity)
        }
    }
}
