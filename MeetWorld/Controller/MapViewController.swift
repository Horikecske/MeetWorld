//
//  MapViewController.swift
//  MeetWorld
//
//  Created by Nyilas Zsombor on 2022. 04. 13..
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    private var observation: NSKeyValueObservation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subscribeToObservable()
        
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(recognizer:)))
        mapView.addGestureRecognizer(longPressRecognizer)
    }
    
    private func subscribeToObservable() {
        observation = UserManager.shared.observe(\.users, changeHandler: { [weak self] _, _ in
            if let strongSelf = self {
                strongSelf.mapView.removeAnnotations(strongSelf.mapView.annotations)
                strongSelf.mapView.addAnnotations(UserManager.shared.users)
            }
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        UserManager.shared.downloadUsers()
    }
    
    @objc func handleLongPress(recognizer: UILongPressGestureRecognizer) {
        if recognizer.state == .began {
            let storyboard = UIStoryboard(name: "Main", bundle: .main)
            let navigationController = storyboard.instantiateViewController(withIdentifier: "UpdateUserNavigationController") as! UINavigationController
            let updateUserVC = navigationController.viewControllers[0] as! UpdateUserViewController
            let touchPoint = recognizer.location(in: mapView)
            updateUserVC.coordinate = mapView.convert(touchPoint, toCoordinateFrom: mapView)
            
            present(navigationController, animated: true, completion: nil)
        }
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
