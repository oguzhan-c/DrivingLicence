//
//  ConversationList.swift
//  DrivingLicence
//
//  Created by Oğuzhan Can on 1.06.2023.
//
import SwiftUI
import RealmSwift

struct ConversationListView: View {
    
    @EnvironmentObject var state: AppState
    @Binding var user: User
    @ObservedRealmObject var userDetail : UserDetail

    var isPreview = false
    
    @State private var conversation: Conversation?
    @State private var showingAddChat = false
    
    private let sortDescriptors = [
        SortDescriptor(keyPath: "unreadCount", ascending: false),
        SortDescriptor(keyPath: "displayName", ascending: true)
    ]
    
    var body: some View {
        ZStack {
            VStack {
                let conversations = userDetail.conversations
                
                List(conversations){ conversation in
                    NavigationLink(destination: ChatRoomView(userdetail: userDetail, user: $user , conversation: conversation)) {
                        ConversationCardView(user: $user, conversation: conversation)
                    }
                    
                }
                Button(action: {showingAddChat.toggle()}) {
                    Text("New Chat Room")
                }
                .disabled(showingAddChat)
                Spacer()
            }
        }
        .onAppear {
            $userDetail.presenceState.wrappedValue = .onLine
        }
        .sheet(isPresented: $showingAddChat) {
            NewConversationView(userDetail: userDetail, user: $user)
                .environmentObject(state)
                .environment(\.realmConfiguration, user.flexibleSyncConfiguration())
        }
    }
}
