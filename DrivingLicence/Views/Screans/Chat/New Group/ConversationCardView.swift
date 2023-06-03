//
//  ConversationCardView.swift
//  DrivingLicence
//
//  Created by Oğuzhan Can on 1.06.2023.
//

import SwiftUI
import RealmSwift

struct ConversationCardView: View {

    let conversation: Conversation
    
    var body: some View {
        VStack {
                ConversationCardContentsView(conversation: conversation)
        }
    }
}
