//
//  MapViewController.swift
//  MeetWorld
//
//  Created by Nyilas Zsombor on 2022. 04. 13..
//

import UIKit
import MapKit
import RxSwift
import RxMKMapView

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    // DisposeBag for disposing subscriptions
    private let bag = DisposeBag()
    var viewModel: MapViewModeling!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        bindMapView()
        
        // adds long press recognizer, so the users can update their statuses with a long press
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(recognizer:)))
        mapView.addGestureRecognizer(longPressRecognizer)
    }
    
    // binds the users to the annotations on the map view
    private func bindMapView() {
        viewModel.users
            .asDriver(onErrorJustReturn: [])
            .drive(self.mapView.rx.annotations)
            .disposed(by: bag)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.downloadUsers()        
    }
        
    // long press recognizer, which instantiates the UpdateUserNavigationController
    @objc func handleLongPress(recognizer: UILongPressGestureRecognizer) {
        if recognizer.state == .began {
            let storyboard = UIStoryboard(name: "Main", bundle: .main)
            let navigationController = storyboard.instantiateViewController(withIdentifier: "UpdateUserNavigationController") as! UINavigationController
            let updateUserVC = navigationController.viewControllers[0] as! UpdateUserViewController
            // adding a dismiss action to the controller, so that dismissing the view
            // causes the users to be downloaded again
            updateUserVC.addDismissAction {
                self.viewModel.downloadUsers()
            }
            let touchPoint = recognizer.location(in: mapView)
            updateUserVC.coordinate = mapView.convert(touchPoint, toCoordinateFrom: mapView)
            
            present(navigationController, animated: true, completion: nil)
        }
    }

}
