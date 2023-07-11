//
//  MugShotGridView.swift
//  DrivingLicence
//
//  Created by Oğuzhan Can on 6.06.2023.
//

import SwiftUI

struct MugShotGridView: View {
    
    @EnvironmentObject var errorHandler: ErrorHandler
    
    let members: [UserDetail]
    
    private let rows = [
        GridItem(.flexible())
    ]
    
    private enum Dimensions {
        static let spacing: CGFloat = 0
        static let height: CGFloat = 40.0
    }
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: true) {
            LazyHGrid(rows: rows, alignment: .center, spacing: Dimensions.spacing) {
                ForEach(members) { member in
                    UserAvatarView(
                        photo: member.userPreferences?.avatarImage,
                        online: member.presenceState == .onLine ? true : false
                    )
                }
            }
            .frame(height: Dimensions.height)
        }
    }
}
