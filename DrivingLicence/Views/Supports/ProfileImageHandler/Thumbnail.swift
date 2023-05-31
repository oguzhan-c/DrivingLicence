//
//  Thumbnail.swift
//  DrivingLicence
//
//  Created by Oğuzhan Can on 31.05.2023.
//

import UIKit
import SwiftUI

struct Thumbnail: View {
    let imageData: Data
    
    var body: some View {
        Image(uiImage: (UIImage(data: imageData) ?? UIImage()))
        .resizable()
        .aspectRatio(contentMode: .fit)
    }
}
