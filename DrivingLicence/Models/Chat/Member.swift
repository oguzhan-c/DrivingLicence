//
//  Member.swift
//  DrivingLicence
//
//  Created by Oğuzhan Can on 28.05.2023.
//

import Foundation
import RealmSwift

class Member: EmbeddedObject, ObjectKeyIdentifiable {
    @Persisted var userName = ""
    @Persisted var membershipStatus = "User added, but invite pending"
    
    convenience init(_ userName: String) {
        self.init()
        self.userName = userName
        membershipState = .pending
    }
    
    convenience init(userName: String, state: MembershipStatus) {
        self.init()
        self.userName = userName
        membershipState = state
    }
    
    var membershipState: MembershipStatus {
        get { return MembershipStatus(rawValue: membershipStatus) ?? .left }
        set { membershipStatus = newValue.asString }
    }
}

enum MembershipStatus: String {
    case pending = "User added, but invite pending"
    case invited = "User has been invited to join"
    case active = "Membership active"
    case left = "User has left"
    
    var asString: String {
        self.rawValue
    }
}
