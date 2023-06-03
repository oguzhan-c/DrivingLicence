//
//  ChatBubbleView.swift
//  DrivingLicence
//
//  Created by Oğuzhan Can on 3.06.2023.
//

import SwiftUI
import RealmSwift

struct ChatBubbleView: View {
    let chatMessage: ChatMessage
    let authorName: String?
    
    private var isMyMessage: Bool { authorName == nil }
    
    private enum Dimensions {
        static let padding: CGFloat = 4
        static let horizontalOffset: CGFloat = 100
        static let cornerRadius: CGFloat = 15
    }
    
    var body: some View {
        HStack {
            if isMyMessage { Spacer().frame(width: Dimensions.horizontalOffset) }
            VStack {
                HStack {
                    if let authorName = authorName {
                            AuthorView(userName: authorName)
                    }
                    Spacer()
                    TextDate(date: chatMessage.time)
                        .font(.caption)
                }
                HStack {
                    if let photo = chatMessage.image {
                        ThumbnailWithExpand(photo: photo)
                        .padding(Dimensions.padding)
                    }
                    if chatMessage.text != "" {
                        MarkDown(text: chatMessage.text)
                        .padding(Dimensions.padding)
                    }
                    Spacer()
                }
            }
            .padding(Dimensions.padding)
            .background(Color(isMyMessage ? "MyBubble" : "OtherBubble"))
            .clipShape(RoundedRectangle(cornerRadius: Dimensions.cornerRadius))
            if !isMyMessage { Spacer().frame(width: Dimensions.horizontalOffset) }
        }
    }
}
