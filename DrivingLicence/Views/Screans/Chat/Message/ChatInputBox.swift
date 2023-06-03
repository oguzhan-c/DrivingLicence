//
//  ChatInputBox.swift
//  DrivingLicence
//
//  Created by Oğuzhan Can on 3.06.2023.
//

import SwiftUI
import RealmSwift

struct ChatInputBox: View {
    
    @ObservedRealmObject var userDetail : UserDetail
    var send: (_: ChatMessage) -> Void = { _ in }
    var focusAction: () -> Void = {}
    
    @FocusState var isTextFocussed: Bool
    
    private enum Dimensions {
        static let maxHeight: CGFloat = 100
        static let minHeight: CGFloat = 100
        static let radius: CGFloat = 10
        static let imageSize: CGFloat = 70
        static let padding: CGFloat = 15
        static let toolStripHeight: CGFloat = 35
    }
    
    @State var photo: Photo?
    @State var chatText = ""
    
    private var isEmpty: Bool { photo == nil && chatText == "" }
    
    var body: some View {
        VStack {
            HStack {
                if let photo = photo {
                    ThumbnailWithDelete(photo: photo, action: deletePhoto)
                }
                TextEditor(text: $chatText)
                    .onTapGesture(perform: focusAction)
                    .focused($isTextFocussed)
                    .padding(Dimensions.padding)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: Dimensions.minHeight, maxHeight: Dimensions.maxHeight)
                    .background(Color("GreenBackground"))
                    .clipShape(RoundedRectangle(cornerRadius: Dimensions.radius))
            }
            HStack {
                Spacer()
                AttachButton(action: addAttachment, active: photo == nil)
                CameraButton(action: takePhoto, active: photo == nil)
                SendButton(action: sendChat, active: !isEmpty)
            }
            .frame(height: Dimensions.toolStripHeight)
        }
        .padding(Dimensions.padding)
        .onAppear(perform: onAppear)
    }
    
    private func onAppear() {
        clearBackground()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            isTextFocussed = true
        }
    }
    
    private func takePhoto() {
        PhotoCaptureController.show(source: .camera) { controller, photo in
            self.photo = photo
            controller.hide()
        }
    }
    
    private func addAttachment() {
        PhotoCaptureController.show(source: .photoLibrary) { controller, photo in
            self.photo = photo
            controller.hide()
        }
    }
    
    private func deletePhoto() {
        photo = nil
    }
    
    private func sendChat() {
        sendMessage(text: chatText, photo: photo)
        photo = nil
        chatText = ""
        isTextFocussed = true
    }
    
    private func clearBackground() {
        UITextView.appearance().backgroundColor = .clear
    }
    
    private func sendMessage(text: String, photo: Photo?) {
            let chatMessage = ChatMessage(
                author: userDetail.email,
                ownerid: userDetail.owner_id,
                text: text,
                image: photo
            )
            send(chatMessage)
    }
}
