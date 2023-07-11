//
//  ConversationCardView.swift
//  DrivingLicence
//
//  Created by Oğuzhan Can on 6.06.2023.
//

import SwiftUI

import SwiftUI
import RealmSwift

struct ConversationCardView: View {
    
    @EnvironmentObject var state: AppState
    @ObservedResults(CloneOfUser.self) var cloneOfUsers
    @ObservedResults(UserDetail.self) var userDetails
    @Environment(\.realm) var realm
    @Binding var user : User
    
    let conversation: Conversation
    
    private struct Dimensions {
        static let mugWidth: CGFloat = 110
        static let cornerRadius: CGFloat = 5
        static let lineWidth: CGFloat = 1
        static let padding: CGFloat = 5
    }
    
    var chatMembers: [UserDetail] {
        var userDetailList = [UserDetail]()
        for member in conversation.members {
            userDetailList.append(contentsOf: userDetails.filter("email = %@", member.userName))
        }
        return userDetailList
        //all member get from UserDetails
    }
        var body: some View {
            HStack {
                MugShotGridView(members: chatMembers)
                    .frame(width: Dimensions.mugWidth)
                    .padding(.trailing)
                VStack(alignment: .leading) {
                    Text(conversation.displayName)
                        .fontWeight(conversation.unreadCount > 0 ? .bold : .regular)
                    CaptionLabel(title: conversation.unreadCount == 0 ? "" :
                                    "\(conversation.unreadCount) new \(conversation.unreadCount == 1 ? "message" : "messages")")
                }
                Spacer()
            }
            .padding(Dimensions.padding)
            .overlay(
                RoundedRectangle(cornerRadius: Dimensions.cornerRadius)
                    .stroke(Color.gray, lineWidth: Dimensions.lineWidth)
            )
        }
    }
