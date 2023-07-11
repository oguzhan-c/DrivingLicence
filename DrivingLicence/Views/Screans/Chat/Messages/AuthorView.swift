//
//  AuthorView.swift
//  DrivingLicence
//
//  Created by Oğuzhan Can on 16.06.2023.
//

import SwiftUI
import RealmSwift

struct AuthorView: View {
    @ObservedResults(UserDetail.self) var userDetails
    
    let _email : String
    
    var userDetail : UserDetail? {
        userDetails.filter("userName = %@", _email).first
        //get first user which userDetail.email equel to _email
    }
    private enum Dimensions{
        static let authorHeight : CGFloat = 25
        static let padding : CGFloat = 4
    }
    var body: some View {
        if let author = userDetail{
            HStack{
                if let photo = author.userPreferences?.avatarImage{
                    AvatarThumbNailView(photo: photo , imageSize: Dimensions.authorHeight)
                }
                if let name = author.userPreferences?.displayName {
                    Text(name)
                    .font(.caption)
                } else {
                    Text(author.email)
                        .font(.caption)
                }
                Spacer()
            }
            .frame(maxHeight: Dimensions.authorHeight)
            .padding(Dimensions.padding)
        }
    }
}

