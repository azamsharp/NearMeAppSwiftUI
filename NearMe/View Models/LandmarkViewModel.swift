//
//  LandmarkViewModel.swift
//  NearMe
//
//  Created by Mohammad Azam on 5/5/21.
//

import Foundation
import MapKit

struct LandmarkViewModel: Identifiable {
    
    let placemark: MKPlacemark
    
    let id = UUID()
    
    var name: String {
        placemark.name ?? ""
    }
    
    var title: String {
        placemark.title ?? ""
    }
    
    var coordinate: CLLocationCoordinate2D {
        placemark.coordinate 
    }
    
}
