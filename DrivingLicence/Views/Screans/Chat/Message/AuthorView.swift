//
//  AuthorView.swift
//  DrivingLicence
//
//  Created by Oğuzhan Can on 3.06.2023.
//

import SwiftUI
import RealmSwift

struct AuthorView: View {
    @ObservedResults(CloneOfUser.self) var cloneOfUsers
    
    let userName: String
    
    var chatster: CloneOfUser? {
        cloneOfUsers.filter("userName = %@", userName).first
    }
    
    private enum Dimensions {
        static let authorHeight: CGFloat = 25
        static let padding: CGFloat = 4
    }
    
    var body: some View {
        if let author = chatster {
            HStack {
                if let photo = author.avatarImage {
                    AvatarThumbNailView(photo: photo, imageSize: Dimensions.authorHeight)
                }
                if let name = author.displayName {
                    Text(name)
                    .font(.caption)
                } else {
                    Text(author.userName)
                        .font(.caption)
                }
                Spacer()
            }
            .frame(maxHeight: Dimensions.authorHeight)
            .padding(Dimensions.padding)
        }
    }
}
