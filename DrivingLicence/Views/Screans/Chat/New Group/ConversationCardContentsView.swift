//
//  ConversationCardContentsView.swift
//  DrivingLicence
//
//  Created by Oğuzhan Can on 1.06.2023.
//

import SwiftUI
import RealmSwift

struct ConversationCardContentsView: View {
    @ObservedResults(CloneOfUser.self) var cloneOfUsers
    
    let conversation: Conversation
    
    private struct Dimensions {
        static let mugWidth: CGFloat = 110
        static let cornerRadius: CGFloat = 5
        static let lineWidth: CGFloat = 1
        static let padding: CGFloat = 5
    }
    
    var chatMembers: [CloneOfUser] {
        var cloneOfUsersList = [CloneOfUser]()
        for member in conversation.members {
            cloneOfUsersList.append(contentsOf: cloneOfUsers.filter("userName = %@", member.userName))
        }
        return cloneOfUsersList
    }
    
    var body: some View {
        HStack {
            ConvesationAvatarsPreView(members: chatMembers)
                .frame(width: Dimensions.mugWidth)
                .padding(.trailing)
            VStack(alignment: .leading) {
                if let subject = conversation.subject{
                    Text(conversation.subject!)
                        .fontWeight(conversation.unreadCount > 0 ? .bold : .regular)
                }
                else{
                    Text(conversation.displayName)
                        .fontWeight(conversation.unreadCount > 0 ? .bold : .regular)
                }
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
