//
//  CoordinateMadel.swift
//  TorchOfLocation
//
//  Created by Sergey Volkov on 22.02.2021.
//

import Foundation
import MapKit

struct CoordinateModel: Identifiable {
    let id = UUID()
    let latitude: Double
    let longitude: Double
    
    var coordinate: CLLocationCoordinate2D {
      CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}



