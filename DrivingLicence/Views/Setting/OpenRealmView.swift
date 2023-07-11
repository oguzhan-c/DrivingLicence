import SwiftUI
import RealmSwift

/// Called when login completes. Opens the realm asynchronously and navigates to the Items screen.
struct OpenRealmView: View {
    @AutoOpen(appId: theAppConfig.appId, timeout: 8000) var autoOpen
    // We must pass the user, so we can set the user.id when we create Item objects
    @State var user: User
    // Configuration used to open the realm.
    @Environment(\.realmConfiguration) private var config
    @ObservedResults(UserDetail.self) var userDetails
    @Environment(\.realm) var realm
    
    var body: some View {
        switch autoOpen {
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
            ZStack{

                if let userDetail = userDetails.last{
                    if userDetail.owner_id == user.id{
                        MainTabbarView(user: $user , userDetail: userDetails.last!)
                                        .environment(\.realm, realm)
                    }
                    else{
                       AccountView(user: $user)
                            .environment(\.realm , realm)
                            .environment(\.realmConfiguration, user.flexibleSyncConfiguration())
                    }
                }
                //When first time login go to the account view and add some account detail
                else{
                   AccountView(user: $user)
                        .environment(\.realm , realm)
                        .environment(\.realmConfiguration, user.flexibleSyncConfiguration())
                }
            }
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
