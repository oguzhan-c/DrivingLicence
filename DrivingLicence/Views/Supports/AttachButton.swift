//
//  AttachButton.swift
//  DrivingLicence
//
//  Created by Oğuzhan Can on 3.06.2023.
//

import SwiftUI

struct AttachButton: View {
    let action: () -> Void
    var active = true
    
    var body: some View {
        ButtonTemplate(action: action, active: active, activeImage: "paperclip", inactiveImage: "paperclip")
    }
}
