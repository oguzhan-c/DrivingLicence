//
//  OnOffCircleView.swift
//  DrivingLicence
//
//  Created by Oğuzhan Can on 1.06.2023.
//

import SwiftUI

struct OnOffCircleView: View {
    let online: Bool
    
    private enum Dimensions {
        static let frameSize: CGFloat = 14.0
        static let innerCircleSize: CGFloat = 10
    }

    var body: some View {
        ZStack {
            Circle()
                .fill(Color.gray)
                .frame(width: Dimensions.frameSize, height: Dimensions.frameSize)
            Circle()
                .fill(online ? Color.green : Color.red)
                .frame(width: Dimensions.innerCircleSize, height: Dimensions.innerCircleSize)
        }
    }
}
