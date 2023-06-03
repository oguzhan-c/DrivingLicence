//
//  ConvesationAvatarsPreViewView.swift
//  DrivingLicence
//
//  Created by Oğuzhan Can on 1.06.2023.
//

import SwiftUI
import RealmSwift

struct ConvesationAvatarsPreView: View {
    let members: [CloneOfUser]
    
    private let rows = [
        GridItem(.flexible())
    ]
    
    private enum Dimensions {
        static let spacing: CGFloat = 0
        static let height: CGFloat = 50.0
    }
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: true) {
            LazyHGrid(rows: rows, alignment: .center, spacing: Dimensions.spacing) {
                ForEach(members) { member in
                    UserAvatarView(
                        photo: member.avatarImage,
                        online: member.presenceState == .onLine ? true : false)
                }
            }
            .frame(height: Dimensions.height)
        }
    }
}
