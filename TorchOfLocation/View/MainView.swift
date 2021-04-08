//
//  ContentView.swift
//  TorchOfLocation
//
//  Created by Sergey Volkov on 22.02.2021.
//

import SwiftUI
import MapKit
import CoreLocation
import AVFoundation

struct MainView: View {
    
    @EnvironmentObject var manager: LocationManager
    
    var body: some View {
        ZStack {
            LocationView()
            VStack {
                
                if !manager.isLocation {
                    Spacer()
                    Text("Location not found")
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .foregroundColor(Color(UIColor.systemBackground))
//                                .shadow(color: .gray, radius: 4, x: 4, y: 4)
                        )
                }
                
                Spacer()
                Button(action: {
                    withAnimation {
                        DispatchQueue.main.async {
                            manager.isLocation.toggle()
                        }
                        toggleTorch(on: manager.isLocation)
                    }
                }, label: {
                    ZStack {
                        Circle()
                            .frame(width: 100, height: 100, alignment: .center)
                            .foregroundColor(manager.isLocation ? .white : .gray).opacity(manager.isLocation ? 1 : 0.5)
//                            .shadow(color: .gray, radius: 4, x: 4, y: 4)
                        Image(systemName: manager.isLocation ? "flashlight.on.fill" : "flashlight.off.fill")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 24, height: 24, alignment: .center)
                            .foregroundColor(.black)
                    }
                })
            }
            
        }
    }
    
    
    private func toggleTorch(on: Bool) {
        guard let device = AVCaptureDevice.default(for: .video) else { return }

        if device.hasTorch {
            do {
                try device.lockForConfiguration()

                if on == true {
                    device.torchMode = .on
                } else {
                    device.torchMode = .off
                }

                device.unlockForConfiguration()
            } catch {
                print("Torch could not be used")
            }
        } else {
            print("Torch is not available")
        }
    }
}
