//
//  UserManager.swift
//  MeetWorld
//
//  Created by Nyilas Zsombor on 2022. 04. 13..
//

import Foundation

class UserManager: NSObject {
    
    //MARK: Observable property
    @objc dynamic private(set) var users: [User]
    static let shared = UserManager()

    private override init() {
        users = [User]()
        super.init()
    }
    
    func downloadUsers() {
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: OperationQueue.main)
        let url = URL(string: "https://meetworld.getsandbox.com/users")!
        let dataTask = session.dataTask(with: url) { data, _, _ in
            if let data = data, let receivedString = String(data: data, encoding: .utf8) {
                print("Data received \(receivedString)")
                self.processDownloadedData(data)
            }
        }
        dataTask.resume()
    }
    
    private func processDownloadedData(_ data: Data) {
        guard let users = try? JSONDecoder().decode([User].self, from: data) else {
            print("Error occoured while processing data")
            return
        }
        self.users = users
    }
    
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
