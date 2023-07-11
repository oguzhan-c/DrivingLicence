//
//  NewConversationView.swift
//  DrivingLicence
//
//  Created by Oğuzhan Can on 6.06.2023.
//


import SwiftUI
import RealmSwift

struct NewConversationView: View {
    @EnvironmentObject var state: AppState
    @Environment(\.presentationMode) var presentationMode
    @ObservedResults(CloneOfUser.self) var cloneOfUsers
    @Environment(\.realm) var realm

    @ObservedRealmObject var userDetail : UserDetail
    @Binding var user : User


    @State private var name = ""
    @State private var members = [String]()

    @State private var candidateMember = ""
    @State private var candidateMembers = [String]()

    private var isEmpty: Bool {
        !(name != "" && members.count > 0)
    }

    private var memberList: [String] {
          candidateMember == ""
              ? cloneOfUsers.compactMap {
                  userDetail.email != $0.userName && !members.contains($0.userName)
                      ? $0.userName
                      : nil }
              : candidateMembers
      }


    var body: some View {
        let searchBinding = Binding<String>(
            get: { candidateMember },
            set: {
                candidateMember = $0
                searchUsers()
            }
        )

        return NavigationView {
            ZStack {
                VStack {
                    TextField("Chat Name", text: $name)
                    CaptionLabel(title: "Add Members")
                    SearchBox(searchText: searchBinding)
                    List {
                        ForEach(memberList, id: \.self) { member in
                            Button(action: {
                                if members.contains(member){
                                  print("error")
                                }else{
                                    members.append(member)
                                    candidateMember = ""
                                    searchUsers()
                                }
                            }) {
                                HStack {
                                    Text(member)
                                    Spacer()
                                    Image(systemName: "plus.circle.fill")
                                    .renderingMode(.original)
                                }
                            }
                        }
                    }
                    Divider()
                    CaptionLabel(title: "Members")
                    List {
                        ForEach(members, id: \.self) { member in
                            Text(member)
                        }
                        .onDelete(perform: deleteMember)
                    }
                    Spacer()
                }
                Spacer()
                if let error = state.error {
                    Text("Error: \(error)")
                        .foregroundColor(Color.red)
                }
            }
            .padding()
            .navigationBarTitle("New Chat", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Dismiss") { presentationMode.wrappedValue.dismiss()
                        print(members)
                        print(memberList)
                        print(candidateMembers)


                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    VStack{
                        SaveConversationButton(userDetail: userDetail, user: $user, name: name, members: members).environment(\.realmConfiguration, user.flexibleSyncConfiguration())
                    }
                }
            }
        }
        .onAppear {
            setSubscription()
            searchUsers()
        }
    }

    private func addMember(_ newMember: String) {
        state.error = nil
        if members.contains(newMember) {
            state.error = "\(newMember) is already part of this chat"
        } else {
            members.append(newMember)
            candidateMember = ""
            searchUsers()
        }
    }

    private func saveConversation() {
        state.error = nil
        let conversation = Conversation()
        conversation.displayName = name
        conversation.members.append(Member(userName: userDetail.userName, state: .active))
        conversation.members.append(objectsIn: members.map { Member($0) })
        $userDetail.conversations.append(conversation)
        presentationMode.wrappedValue.dismiss()
        print(Member().self)
    }

    private func searchUsers() {
        var candidateCloneOfUsers: Results<CloneOfUser>
        if candidateMember == "" {
            candidateCloneOfUsers = cloneOfUsers
        } else {
            let predicate = NSPredicate(format: "userName CONTAINS[cd] %@", candidateMember)
            candidateCloneOfUsers = cloneOfUsers.filter(predicate)
        }
        candidateMembers = []
        candidateCloneOfUsers.forEach { cloneOfUser in
            if !members.contains(cloneOfUser.userName) && cloneOfUser.userName != userDetail.userName {
                candidateMembers.append(cloneOfUser.userName)
            }
        }
    }



    private func deleteMember(at offsets: IndexSet) {
        members.remove(atOffsets: offsets)
    }

    private func setSubscription() {
        let subscriptions = realm.subscriptions
        subscriptions.update {
            if let currentSubscription = subscriptions.first(named: "CloneOFUser") {
                currentSubscription.updateQuery(toType: CloneOfUser.self) {
                    $0.userName != ""
                }

            } else {
                subscriptions.append(QuerySubscription<CloneOfUser>(name: "CloneOFUser") {
                    $0.userName != ""
                })
            }
        }
    }
}


//import SwiftUI
//import RealmSwift
//
//struct NewConversationView : View{
//    @ObservedRealmObject var userDetail : UserDetail
//    @Binding var user : User
//
//    @ObservedResults(CloneOfUser.self) var cloneOfUsers
//    @Environment(\.presentationMode) var presentationMode
//    @EnvironmentObject var errorHandler: ErrorHandler
//
//    @State private var chatName = ""
//    @State private var members = [String]()
//
//    private var isEmpty: Bool {
//        !(chatName != "" && members.count > 0)
//    }
//
//    var body: some View{
//        return NavigationView {
//            ZStack{
//                VStack{
//                    TextField("Chat Name" , text: $chatName)
//                    CaptionLabel(title: "Add Members")
//                    List{
//                        ForEach(cloneOfUsers){ cloneOfUser in
////                            if cloneOfUser.userName != userDetail.email {
//////                                Button(action: { addMember(cloneOfUser.userName) }) {
//////                                    HStack {
//////                                        Text(cloneOfUser.userName)
//////                                        Spacer()
//////                                        Image(systemName: "plus.circle.fill")
//////                                        .renderingMode(.original)
//////                                    }
//////                                }
////                                Text(cloneOfUser.userName)
////                            }
////                            else{
////                                Text("did not mach : \(cloneOfUser.userName)")
////                            }
//                            Text(cloneOfUser.userName)
//                        }
//                    }// all cloneOfUsers in cloneOfuser object if equell to userdetail.email and if not  added members then sent the addMember func with cloneOfUser.userName
//                    Divider()
//                    CaptionLabel(title: "Members")
//                    List{
//                        ForEach(members , id: \.self){member in
//                            Text(member)
//                        }
//                        .onDelete(perform: deleteMember)
//                    }
//                    Spacer()
//                }
//                Spacer()
//                if let error = errorHandler.stringError{
//                    Text(error)
//                        .foregroundColor(Color.red)
//                }
//            }
//            .padding()
//            .navigationBarTitle("New Chat", displayMode: .inline)
//            .toolbar{
//                ToolbarItem(placement: .navigationBarLeading) {
//                    Button("Dismiss"){
//                        presentationMode.wrappedValue.dismiss()
//                    }
//                }
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    SaveConversationButton(userDetail: userDetail, user: $user, name: chatName, members: members , done: {
//                        presentationMode.wrappedValue.dismiss()
//                    })
//                        .environment(\.realmConfiguration, user.flexibleSyncConfiguration())
//                }
//            }
//            .disabled(isEmpty)
//            .padding()
//        }
//    }
//    private func deleteMember(at offsets: IndexSet) {
//        members.remove(atOffsets: offsets)
//    }
//
//    private func addMember(_ newMember: String) {
//        if members.contains(newMember) {
//            errorHandler.stringError = "\(newMember) is already part of this chat"
//            print("\(newMember) is already part of this chat")
//        } else {
//            members.append(newMember)
//        }
//    }
//}
