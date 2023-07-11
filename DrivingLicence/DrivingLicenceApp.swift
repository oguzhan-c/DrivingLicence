//
//  App.swift
//  DrivingLicence
//
//  Created by Oğuzhan Can on 22.03.2023.
//

import SwiftUI
import RealmSwift


let theAppConfig = loadDrivingLicenceAppConfig()

let app = App(id: theAppConfig.appId, configuration: AppConfiguration(baseURL: theAppConfig.baseUrl, transport: nil, localAppName: nil, localAppVersion: theAppConfig.localAppVersion))

@main
struct realmSwiftUIApp: SwiftUI.App {
    @StateObject var errorHandler = ErrorHandler(app: app)
    @StateObject private var realmController = RealmController()
    @StateObject var state = AppState()

    var body: some Scene {
        WindowGroup {
            ContentView(app: app)
                .environmentObject(errorHandler)
                .environmentObject(realmController) //Actiave Migration
                .environmentObject(state)
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
    @Published var stringError: String?

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
            schemaVersion: 17,
            migrationBlock: { migration, oldSchemaVersion in
                if oldSchemaVersion < 17 {
                    migration.enumerateObjects(ofType: Category.className()) { oldObject, newObject in
                        newObject!["owner_id"] = String.self
                    }
                    migration.enumerateObjects(ofType: Conversation.className()) { oldObject, newObject in
//                        // Delete object Migration Sample
//                        if oldObject!["owner_Id"] as? String == "objectToDeleteID"{
//                            migration.delete(oldObject!)
//                        }
//                        // Change Object Type Migration Sample
//                        newObject!["TotalQuectionNumber"] = Double(oldObject!["TotalQuectionNumber"] as! Int)
//                        //Add new Object Migration Sample
//                        newObject!["members"] = [Member].self
                        newObject!["subject"] = String.self
                    }
                    migration.enumerateObjects(ofType: UserDetail.className()) { oldObject, newObject in
                        newObject!["userName"] = String.self
                    }
                    migration.enumerateObjects(ofType: CloneOfUser.className()) { oldObject, newObject in
                        if oldObject!["owner_id"] as? String == "objectToDeleteID"{
                            migration.delete(oldObject!)
                        }
                        newObject!["owner_id"] = String.self
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
