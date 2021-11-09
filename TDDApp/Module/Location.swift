//
//  Location.swift
//  TDDApp
//
//  Created by Oleg Kanatov on 3.11.21.
//

import Foundation
import CoreLocation

struct Location {
    
    var name: String
    let coordinate: CLLocationCoordinate2D?
    
    var dict: [String : Any] {
        var dict: [String : Any] = [:]
        dict["name"] = name
        if let coordinate = coordinate {
            dict["latitude"] = coordinate.latitude
            dict["longitude"] = coordinate.longitude
        }
        return dict
    }
    
    init(name: String, coordinate: CLLocationCoordinate2D? = nil) {
        
        self.name = name
        self.coordinate = coordinate
    }
}

extension Location {
    
    typealias PlistDictionary =  [String : Any]
    init?(dict: PlistDictionary) {
        self.name = dict["name"] as! String
        if let lalitude = dict["latitude"] as? Double,
           let longitude = dict["longitude"] as? Double {
            self.coordinate = CLLocationCoordinate2D(latitude: lalitude, longitude: longitude)
        } else {
            self.coordinate = nil
        }
    }
}

extension Location: Equatable {
    
    static func == (lhs: Location, rhs: Location) -> Bool {
        
        guard rhs.coordinate?.latitude == lhs.coordinate?.latitude && lhs.coordinate?.longitude == rhs.coordinate?.longitude &&
                lhs.name == rhs.name else { return false }
        
        return true
    }
}
