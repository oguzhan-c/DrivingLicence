//
//  BackButton.swift
//  DrivingLicence
//
//  Created by Oğuzhan Can on 3.06.2023.
//

import SwiftUI

struct BackButton: View {
    var label: String = "Back"
    
    private let spacing: CGFloat = 8
    
    var body: some View {
        HStack(spacing: spacing) {
            Image(systemName: "chevron.left")
                .aspectRatio(contentMode: .fit)
            Text(label)
        }
    }
}
