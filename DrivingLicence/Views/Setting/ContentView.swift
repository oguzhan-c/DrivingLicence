import SwiftUI
import RealmSwift

struct ContentView: View {
    @ObservedObject var app: RealmSwift.App
    @EnvironmentObject var errorHandler: ErrorHandler

    var body: some View {
        if let user = app.currentUser{
            // Setup configuraton so user initially subscribes to their own tasks
            let config = user.flexibleSyncConfiguration(initialSubscriptions: { subs in
                if  subs.first(named: "Quection") != nil &&
                        subs.first(named: "Answer") != nil &&
                        subs.first(named: "Category") != nil &&
                        subs.first(named: "Tutorial") != nil &&
                        subs.first(named: "UserStatistic") != nil &&
                        subs.first(named: "ChatMessage") != nil &&
                        subs.first(named: "CloneOfUser") != nil &&
                        subs.first(named: "UserDetail") != nil
                {
                    // Existing subscription found - do nothing
                    return
                } else {
                    // No subscription - create it
                    subs.append(QuerySubscription<Quection>(name: "Quection"))
                    subs.append(QuerySubscription<Answer>(name: "Answer"))
                    subs.append(QuerySubscription<Category>(name: "Category"))
                    subs.append(QuerySubscription<Tutorial>(name: "Tutorial"))
                    subs.append(QuerySubscription<UserStatistic>(name: "UserStatistic"))
                    subs.append(QuerySubscription<ChatMessage>(name: "ChatMessage"))
                    subs.append(QuerySubscription<CloneOfUser>(name: "CloneOfUser"))
                    subs.append(QuerySubscription<UserDetail>(name: "UserDetail"){
                        $0.owner_id == user.id
                    })
                }
            })
            OpenRealmView(user: user)
            // Store configuration in the environment to be opened in next view
                .environment(\.realmConfiguration, config)
        }else {
            // If there is no user logged in, show the login view.
            LoginView()
        }
    }
}
