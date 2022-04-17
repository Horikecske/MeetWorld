//
//  UsersViewModel.swift
//  MeetWorld
//
//  Created by Nyilas Zsombor on 2022. 04. 15..
//

import Foundation
import RxSwift
import RxRelay

// ViewModel of the UsersView
class UsersViewModel: UsersViewModeling {
    
    // BehaviourRelay, so the array can be observed by the table view
    var users = BehaviorRelay<[User]>(value: [])
    var userManager: UserManager
    
    // initializer injection
    init(userManager: UserManager) {
        self.userManager = userManager
    }
    
    // downloads users through the UserManager
    func downloadUsers() {
        userManager.downloadUsers() { users in
            self.users.accept(users)
        }
    }
        
}

protocol UsersViewModeling {
    var users: BehaviorRelay<[User]> { get }
    var userManager: UserManager { get }
    
    func downloadUsers()
}
