//
//  LocationView.swift
//  TorchOfLocation
//
//  Created by Sergey Volkov on 22.02.2021.
//

import SwiftUI
import MapKit

struct LocationView: View {
    
    @EnvironmentObject var manager: LocationManager
    @State var userTrackingMode: MapUserTrackingMode = .follow

        var body: some View {
            Map(coordinateRegion: $manager.region,
                //interactionModes: MapInteractionModes.all,
                showsUserLocation: manager.isLocation,
                userTrackingMode: $userTrackingMode,
                annotationItems: manager.places,
                
                annotationContent: { place in
                MapPin(coordinate: place.coordinate, tint: .red)
            })
            .edgesIgnoringSafeArea(.all)
            
        }
}
