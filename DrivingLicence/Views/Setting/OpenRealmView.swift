import SwiftUI
import RealmSwift

/// Called when login completes. Opens the realm asynchronously and navigates to the Items screen.
struct OpenRealmView: View {
    @AsyncOpen(appId: theAppConfig.appId, timeout: 8000) var asyncOpen
    // We must pass the user, so we can set the user.id when we create Item objects
    @State var user: User
    // Configuration used to open the realm.
    @Environment(\.realmConfiguration) private var config

    var body: some View {
        switch asyncOpen {
        case .connecting:
            // Starting the Realm.asyncOpen process.
            // Show a progress view.
            ProgressView()
        case .waitingForUser:
            // Waiting for a user to be logged in before executing
            // Realm.asyncOpen.
            ProgressView("Waiting for user to log in...")
        case .open(let realm):
            // The realm has been opened and is ready for use.
            MainTabbarView()
                .environment(\.realm, realm)
        case .progress(let progress):
            // The realm is currently being downloaded from the server.
            // Show a progress view.
            ProgressView(progress)
        case .error(let error):
            // Opening the Realm failed.
            // Show an error view.
            ErrorView(error: error)
        }
    }
}
