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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func saveButtonTap(_ sender: Any) {
        guard let coordinate = coordinate,
              let username = usernameTextField.text,
              let status = statusTextField.text else {
                  return
              }
        
        let user = User(id: username,
                        status: status,
                        lat: String(format: "%f", coordinate.latitude),
                        lon: String(format: "%f", coordinate.longitude))
        
        UserManager.shared.update(user: user) { response in
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
