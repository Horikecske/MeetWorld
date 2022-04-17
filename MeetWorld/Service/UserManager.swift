//
//  UserManager.swift
//  MeetWorld
//
//  Created by Nyilas Zsombor on 2022. 04. 16..
//

import Foundation

// protocol that describes the server actions for the app
protocol UserManager {
    
    // downloads users from server
    func downloadUsers(completion: @escaping ([User]) -> Void)
    
    // posts user to server
    func update(user: User, completion: @escaping (UpdateResponse) -> Void)
    
}
