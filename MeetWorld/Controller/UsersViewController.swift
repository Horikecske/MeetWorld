//
//  UsersViewController.swift
//  MeetWorld
//
//  Created by Nyilas Zsombor on 2022. 04. 13..
//

import UIKit

class UsersViewController: UITableViewController {
    
    private var observation: NSKeyValueObservation?

    override func viewDidLoad() {
        super.viewDidLoad()
        subscribeToObservable()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UserManager.shared.users.count
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UserManager.shared.downloadUsers()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserStatusCell", for: indexPath)
        let user = UserManager.shared.users[indexPath.row]
        cell.textLabel?.text = user.id
        cell.detailTextLabel?.text = user.status

        return cell
    }
    
    
    @IBAction func refreshButtonTap(_ sender: Any) {
        UserManager.shared.downloadUsers()
    }
    
    private func subscribeToObservable() {
        observation = UserManager.shared.observe(\.users, changeHandler: { [weak self] _, _ in
            self?.tableView.reloadData()
        })
    }
    

}
