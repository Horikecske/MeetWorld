//
//  User.swift
//  MeetWorld
//
//  Created by Nyilas Zsombor on 2022. 04. 13..
//

import Foundation
import MapKit

// model of the user downloaded from and uploaded to the servers
class User: NSObject, Codable {
    let id: String
    let status: String
    var lat: String
    var lon: String
    
    init(id: String, status: String, lat: String, lon: String) {
        self.id = id
        self.status = status
        self.lat = lat
        self.lon = lon
        
        super.init()
    }
}

// conforming to MKAnnotation, so that the user can easily be added to the map as an annotation
extension User: MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: Double(lat)!, longitude: Double(lon)!)
    }
    
}
