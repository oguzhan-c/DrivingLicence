//
//  ButtonTemplate.swift
//  DrivingLicence
//
//  Created by Oğuzhan Can on 3.06.2023.
//

import SwiftUI

struct ButtonTemplate: View {
    let action: () -> Void
    var active = true
    var activeImage = "paperplane.fill"
    var inactiveImage = "paperplane"
    var padding: CGFloat = 4
    
    private enum Dimensions {
        static let buttonSize: CGFloat = 60
        static let activeOpactity = 0.8
        static let disabledOpactity = 0.2
    }
    
    var body: some View {
        Button(action: { if active { action() } }) {
            Image(systemName: active ? activeImage : inactiveImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.primary)
                .opacity(active ? Dimensions.activeOpactity : Dimensions.disabledOpactity)
                .padding(padding)
        }
    }
}
