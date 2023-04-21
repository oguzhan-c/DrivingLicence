//
//  ErrorView.swift
//  DrivingLicence
//
//  Created by Oğuzhan Can on 23.03.2023.
//

import SwiftUI

struct ErrorView: View {
    @State var error: Error
        
    var body: some View {
        Text("Error: \(error.localizedDescription)")
    }
}
