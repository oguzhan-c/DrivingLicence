//
//  BlankPersonIconView.swift
//  DrivingLicence
//
//  Created by Oğuzhan Can on 1.06.2023.
//

import SwiftUI

struct BlankPersonIconView: View {
    var body: some View {
        Image(systemName: "person.crop.circle.fill")
            .resizable()
            .foregroundColor(.gray)
    }
}
