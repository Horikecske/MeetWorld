//
//  MockUserManager.swift
//  MeetWorld
//
//  Created by Nyilas Zsombor on 2022. 04. 18..
//

import Foundation

// mock implementation of UserManager, returns a static array of users
// and static responses for the post call, for testing purposes
class MockUserManager: UserManager {
    
    // returns 2 users
    func downloadUsers(completion: @escaping ([User]) -> Void) {
        let user1 = User(id: "test1", status: "test status 1", lat: "47.481412653021955", lon: "19.052128483954863")
        let user2 = User(id: "test2", status: "test status 2", lat: "46.235860", lon: "17.365708")
        let users = [user1, user2]
        completion(users)
    }
    
    // returns static string 
    func update(user: User, completion: @escaping (UpdateResponse) -> Void) {
        let response = UpdateResponse(result: "test result ok", status: "test status ok")
        completion(response)
    }
    
    
}
