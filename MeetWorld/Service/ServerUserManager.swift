//
//  UserManager.swift
//  MeetWorld
//
//  Created by Nyilas Zsombor on 2022. 04. 13..
//

import Foundation

// implementation of UserManager, used to fetch users from server, and post new status info as well
class ServerUserManager: UserManager {
    
    // downloads users from server
    func downloadUsers(completion: @escaping ([User]) -> Void) {
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: OperationQueue.main)
        let url = URL(string: "https://meetworld.getsandbox.com/users")!
        let dataTask = session.dataTask(with: url) { data, _, _ in
            if let data = data, let receivedString = String(data: data, encoding: .utf8) {
                guard let users = try? JSONDecoder().decode([User].self, from: data) else {
                    print("Error occoured while processing data")
                    return
                }
                print(receivedString)
                completion(users)
            }
        }
        dataTask.resume()
    }
    
    // posts new user to server
    func update(user: User, completion: @escaping (UpdateResponse) -> Void) {
        let jsonData = try? JSONEncoder().encode(user)
        
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: .main)
        let url = URL(string: "https://meetworld.getsandbox.com/updateuser")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = session.dataTask(with: request, completionHandler: { data, _, _ in
            if let data = data,
               let response = try? JSONDecoder().decode(UpdateResponse.self, from: data) {
                completion(response)
            }
        })
        task.resume()
    }
}
