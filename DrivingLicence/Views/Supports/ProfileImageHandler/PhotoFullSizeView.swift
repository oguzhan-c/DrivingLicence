//
//  PhotoFullSizeView.swift
//  DrivingLicence
//
//  Created by Oğuzhan Can on 3.06.2023.
//

import UIKit
import SwiftUI

struct PhotoFullSizeView: View {
    let photo: Photo

    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            if let picture = photo.picture {
                if let image = UIImage(data: picture) {
                    Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action: { self.presentationMode.wrappedValue.dismiss() }) {
            BackButton(label: "Dismiss")
        })
    }
}
