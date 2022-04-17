//
//  UpdateUserViewModel.swift
//  MeetWorld
//
//  Created by Nyilas Zsombor on 2022. 04. 16..
//

import Foundation
import CoreLocation

// ViewModel of the UpdateUserView
class UpdateUserViewModel: UpdateUserViewModeling {
    
    var userManager: UserManager
    
    // initializer injection
    init(userManager: UserManager) {
        self.userManager = userManager
    }
    
    // creates a User object, which can be passed to the update method
    func createUser(coordinate: CLLocationCoordinate2D, username: String, status: String) -> User {
        let user = User(id: username,
                        status: status,
                        lat: String(format: "%f", coordinate.latitude),
                        lon: String(format: "%f", coordinate.longitude))
        
        return user
    }
    
    // sends post request through the UserManager
    func update(user: User, completion: @escaping (UpdateResponse) -> Void) {
        userManager.update(user: user, completion: completion)
    }
    
}

protocol UpdateUserViewModeling {
    var userManager: UserManager { get }
    
    func createUser(coordinate: CLLocationCoordinate2D, username: String, status: String) -> User
    func update(user: User, completion: @escaping (UpdateResponse) -> Void)
}
