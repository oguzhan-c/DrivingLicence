//
//  App.swift
//  DrivingLicence
//
//  Created by Oğuzhan Can on 22.03.2023.
//

import SwiftUI
import RealmSwift

/// This method loads app config details from a atlasConfig.plist we generate
/// for the template apps.
/// When you create your own Atlas Device Sync app, use your preferred method
/// to store and access app configuration details.
let theAppConfig = loadDrivingLicenceAppConfig()

let app = App(id: theAppConfig.appId, configuration: AppConfiguration(baseURL: theAppConfig.baseUrl, transport: nil, localAppName: nil, localAppVersion: theAppConfig.localAppVersion))

@main
struct realmSwiftUIApp: SwiftUI.App {
    @StateObject var errorHandler = ErrorHandler(app: app)
    @StateObject private var realmController = RealmController()

    var body: some Scene {
        WindowGroup {
            ContentView(app: app)
                .environmentObject(errorHandler)
                .environmentObject(realmController)
                .alert(Text("Error"), isPresented: .constant(errorHandler.error != nil)) {
                    Button("OK", role: .cancel) { errorHandler.error = nil }
                } message: {
                    Text(errorHandler.error?.localizedDescription ?? "")
                }
        }
    }
}

final class ErrorHandler: ObservableObject {
    @Published var error: Swift.Error?

    init(app: RealmSwift.App) {
        // Sync Manager listens for sync errors.
        app.syncManager.errorHandler = { syncError, syncSession in
            self.error = syncError
        }
    }
}

class RealmController: ObservableObject {
    private var realm: Realm

    init() {
        // Perform migration if needed
        // After every migration change schema version
        let config = Realm.Configuration(
            schemaVersion: 5,
            migrationBlock: { migration, oldSchemaVersion in
                if oldSchemaVersion < 5 {
                    migration.enumerateObjects(ofType: UserStatistic.className()) { oldObject, newObject in
                        newObject!["TotalQuectionNumber"] = Double(oldObject!["TotalQuectionNumber"] as! Int)
                        newObject!["CorrectQuectionNumber"] = Double(oldObject!["CorrectQuectionNumber"] as! Int)
                        newObject!["WrongQuectionNumber"] = Double(oldObject?["WrongQuectionNumber"] as! Int)
                        newObject!["date"] = Date()
                    }
                    migration.enumerateObjects(ofType: Member.className()) { oldObject, newObject in
                        newObject!["userName"] = String.self
                        newObject!["membershipStatus"] = String.self
                    }
                    
                    migration.enumerateObjects(ofType: Conversation.className()) { oldObject, newObject in
                        newObject!["displayName"] = String.self
                        newObject!["unreadCount"] = Int.self
                        newObject!["members"] = [Member].self
                    }
                    
                    migration.enumerateObjects(ofType: Photo.className()) { oldObject, newObject in
                        newObject!["thumbNail"] = Data.self
                        newObject!["picture"] = Data.self
                        newObject!["date"] = Date.self
                    }
                    migration.enumerateObjects(ofType: ChatMessage.className()) { oldObject, newObject in
                        newObject!["conversationId"] = ObjectId.self
                        newObject!["author"] = String.self
                        newObject!["text"] = String.self
                        newObject!["image"] = Photo.self
                        newObject!["time"] = Date.self
                        newObject!["ownerId"] = String.self
                    }
                    
                    migration.enumerateObjects(ofType: UserPreferences.className()) { oldObject, newObject in
                        newObject!["displayName"] = String.self
                        newObject!["avatarImage"] = Photo.self
                    }
                    
                    migration.enumerateObjects(ofType: UserDetail.className()) { oldObject, newObject in
                        newObject!["lastSeenAt"] = Date.self
                        newObject!["presence"] = String.self
                        newObject!["conversations"] = [Conversation].self
                    }
                    
                    migration.enumerateObjects(ofType: CloneOfUser.className()) { oldObject, newObject in
                        newObject!["userName"] = String.self
                        newObject!["displayName"] = String.self
                        newObject!["avatarImage"] = Photo.self
                        newObject!["lastSeenAt"] = Date.self
                        newObject!["presence"] = String.self
                    }
                }
            }
        )
        
        Realm.Configuration.defaultConfiguration = config

        do {
            realm = try Realm()
        } catch {
            fatalError("Failed to initialize Realm: \(error.localizedDescription)")
        }
    }
}
