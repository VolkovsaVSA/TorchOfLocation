//
//  LocationManager.swift
//  TorchOfLocation
//
//  Created by Sergey Volkov on 22.02.2021.
//

import MapKit

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var region = MKCoordinateRegion()
    @Published var span = MKCoordinateSpan(latitudeDelta: 3, longitudeDelta: 3)
    @Published var isLocation = false {
        didSet {
            DispatchQueue.global(qos: .utility).async{
                if self.isLocation {
                    self.start()
                    self.region = MKCoordinateRegion(center: self.lastLocation, span: self.span)
                } else {
                    self.region.center = DefaultRegion.center
                    self.manager.stopUpdatingLocation()
                }
            }
            
           
            
        }
    }
    @Published var places: [CoordinateModel] = [
        CoordinateModel(latitude: 37.320, longitude: -122.030),
        CoordinateModel(latitude: 37.323, longitude: -122.033),
        CoordinateModel(latitude: 37.326, longitude: -122.036)
    ]
    
    private let manager = CLLocationManager()
    private var lastLocation = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    
    init(latitude: Double, longitude: Double) {
        super.init()
        manager.delegate = self
        //manager.desiredAccuracy = kCLLocationAccuracyBest
        
        let center = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        region = MKCoordinateRegion(center: center, span: span)
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locations.last.map {
            if isLocation {
                let center = CLLocationCoordinate2D(latitude: $0.coordinate.latitude, longitude: $0.coordinate.longitude)
                lastLocation = $0.coordinate
                region.center = center
                print(center)
            }
        }
    }
    
    func start() {
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
}

let DefaultRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0,
                                                                      longitude: 0),
                                       span: MKCoordinateSpan(latitudeDelta: 1,
                                                              longitudeDelta: 1))
