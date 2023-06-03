//
//  DeleteButton.swift
//  DrivingLicence
//
//  Created by Oğuzhan Can on 3.06.2023.
//

import SwiftUI

struct DeleteButton: View {
    let action: () -> Void
    var active = true
    var padding: CGFloat = 8
    
    var body: some View {
        ButtonTemplate(action: action, active: active, activeImage: "minus.square.fill", inactiveImage: "minus.square", padding: padding)
    }
}
