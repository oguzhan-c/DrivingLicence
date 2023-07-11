//
//  LogoutButton.swift
//  DrivingLicence
//
//  Created by Oğuzhan Can on 23.03.2023.
//

import SwiftUI
import RealmSwift

/// Logout from the synchronized realm. Returns the user to the login/sign up screen.
struct LogoutButton: View {
    @State var isLoggingOut = false
    @State var error: Error?
    @State var errorMessage: ErrorMessage? = nil
    
    @EnvironmentObject var errorHandler: ErrorHandler
    @Environment(\.realm) var realm
    
    var body: some View {
        if isLoggingOut {
            ProgressView()
        }
        Button("Log Out") {
            guard let user = app.currentUser else {
                return
            }
            isLoggingOut = true
            Task {
                await logout(user: user)
                // Other views are observing the app and will detect
                // that the currentUser has changed. Nothing more to do here.
                isLoggingOut = false
            }
        }.disabled(app.currentUser == nil || isLoggingOut)
        // Show an alert if there is an error during logout
            .alert(Text("Error"), isPresented: .constant(errorHandler.error != nil)) {
                Button("OK", role: .cancel) { errorHandler.error = nil }
            } message: {
                Text(errorHandler.error?.localizedDescription ?? "")
            }
    }
    
    /// Asynchronously log the user out, or display an alert with an error if logout fails.
    func logout(user: User) async {
        do {
             try await user.logOut()
             print("Successfully logged user out")
         } catch {
             print("Failed to log user out: \(error.localizedDescription)")
             // SwiftUI Alert requires the item it displays to be Identifiable.
             // Optional Error is not Identifiable.
             // Store the error as errorText in our Identifiable ErrorMessage struct,
             // which we can display in the alert.
             self.errorMessage = ErrorMessage(errorText: error.localizedDescription)
         }
    }
    private func clearSubscriptions() {
        let subscriptions = realm.subscriptions
        subscriptions.update {
            subscriptions.removeAll()
            subscriptions.forEach { subs in
                print(subs.name)
                print(subs.queryString)
            }
        }
    }
}

struct ErrorMessage: Identifiable {
    let id = UUID()
    let errorText: String
}
