//
//  UsersViewController.swift
//  MeetWorld
//
//  Created by Nyilas Zsombor on 2022. 04. 13..
//

import UIKit
import RxSwift
import RxCocoa

class UsersViewController: UITableViewController {
    
    // DisposeBag for disposing subscriptions
    private let bag = DisposeBag()
    var viewModel: UsersViewModeling!

    override func viewDidLoad() {
        super.viewDidLoad()
        bindTableView()
    }
    
    // binds the users stored in the ViewModel to the cell's content in the table view
    private func bindTableView() {
        self.tableView.delegate = nil
        self.tableView.dataSource = nil
        
        viewModel.users.asObservable().bind(to: self.tableView.rx.items(cellIdentifier: "UserStatusCell")) { index, user, cell in
            cell.textLabel?.text = user.id
            cell.detailTextLabel?.text = user.status
        }
        .disposed(by: bag)
        
        viewModel.downloadUsers()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.downloadUsers()
    }
    
    
    @IBAction func refreshButtonTap(_ sender: Any) {
        viewModel.downloadUsers()
    }

}
