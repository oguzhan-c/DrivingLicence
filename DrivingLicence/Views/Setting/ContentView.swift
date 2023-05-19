import SwiftUI
import RealmSwift

struct ContentView: View {
    @ObservedObject var app: RealmSwift.App
    @EnvironmentObject var errorHandler: ErrorHandler

    var body: some View {
        if let user = app.currentUser {
            // Setup configuraton so user initially subscribes to their own tasks
            let config = user.flexibleSyncConfiguration(initialSubscriptions: { subs in
                if  subs.first(named: "Quection") != nil &&
                        subs.first(named: "Answer") != nil &&
                        subs.first(named: "Category") != nil &&
                        subs.first(named: "UserDetail") != nil &&
                        subs.first(named: "Tutorial") != nil &&
                        subs.first(named: "UserStatistic") != nil
                {
                    // Existing subscription found - do nothing
                    print(subs.forEach{ sub in
                        sub.name
                    })
                    return
                } else {
                    // No subscription - create it
                    subs.append(QuerySubscription<Quection>(name: "Quection"))
                    subs.append(QuerySubscription<Answer>(name: "Answer"))
                    subs.append(QuerySubscription<Category>(name: "Category"))
                    subs.append(QuerySubscription<UserDetail>(name: "UserDetail"){
                        $0.owner_Id == user.id
                    })
                    subs.append(QuerySubscription<Tutorial>(name: "Tutorial"){
                        $0.owner_Id == user.id
                    })
                    subs.append(QuerySubscription<UserStatistic>(name: "UserStatistic"))
                }
            })
            OpenRealmView(user: user)
            // Store configuration in the environment to be opened in next view
                .environment(\.realmConfiguration, config)
                .environment(\.realmConfiguration,
                              Realm.Configuration(schemaVersion: 111))
        }else {
            // If there is no user logged in, show the login view.
            MainTabbarView()
        }
    }
}
