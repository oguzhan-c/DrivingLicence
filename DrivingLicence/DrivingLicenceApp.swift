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
                .environmentObject(realmController) //Actiave Migration
                .alert(Text("Error"), isPresented: .constant(errorHandler.swiftError != nil)) {
                    Button("OK", role: .cancel) { errorHandler.swiftError = nil }
                } message: {
                    Text(errorHandler.swiftError?.localizedDescription ?? "")
                }
        }
    }
}

final class ErrorHandler: ObservableObject {
    @Published var swiftError: Swift.Error?
    @Published var stringError: String?

    init(app: RealmSwift.App) {
        // Sync Manager listens for sync errors.
        app.syncManager.errorHandler = { syncError, syncSession in
            self.swiftError = syncError
        }
    }
}

class RealmController: ObservableObject {
    private var realm: Realm

    init() {
        // Perform migration if needed
        // After every migration change schema version
        let config = Realm.Configuration(
            schemaVersion: 13,
            migrationBlock: { migration, oldSchemaVersion in
                if oldSchemaVersion < 13 {
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
