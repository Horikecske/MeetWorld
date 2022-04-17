//
//  UpdateUserViewController.swift
//  MeetWorld
//
//  Created by Nyilas Zsombor on 2022. 04. 13..
//

import UIKit
import CoreLocation

class UpdateUserViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var statusTextField: UITextField!
    
    var coordinate: CLLocationCoordinate2D?
    var viewModel: UpdateUserViewModeling!
    var dismissAction: () -> (Void) = {}
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // adds an action to be performed when dismissing the view,
    // used for downloading the users
    func addDismissAction(action: @escaping () -> (Void)) {
        self.dismissAction = action
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        dismissAction()
    }
    
    
    @IBAction func saveButtonTap(_ sender: Any) {
        guard let coordinate = coordinate,
              let username = usernameTextField.text,
              let status = statusTextField.text else {
                  return
              }
        
        let user = viewModel.createUser(coordinate: coordinate, username: username, status: status)
        
        // sending the post request and presenting an alert with the result of the request
        viewModel.update(user: user) { response in
            let alert = UIAlertController(title: "Response", message: response.result, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: { _ in
                self.dismiss(animated: true, completion: nil)
            })
            alert.addAction(okAction)
            
            self.present(alert, animated: true, completion: nil)
            
        }
    }
    
    @IBAction func cancelButtonTap(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

}
