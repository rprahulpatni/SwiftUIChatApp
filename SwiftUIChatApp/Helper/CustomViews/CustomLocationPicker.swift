//
//  CustomLocationPicker.swift
//  SwiftUIChatApp
//
//  Created by NeoSOFT on 22/08/23.
//

import SwiftUI
import MapKit

//struct CustomLocationPicker: View {
//    @State private var tappedCoordinate: CLLocationCoordinate2D?
//    
////    struct MapPinItem: Identifiable {
////        let id = UUID()
////        let coordinate: CLLocationCoordinate2D
////    }
//    
//    var body: some View {
////        Map(coordinateRegion: .constant(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))), showsUserLocation: true, userTrackingMode: .constant(.follow), annotationItems: [MapPinItem(coordinate: tappedCoordinate ?? CLLocationCoordinate2D(latitude: 0, longitude: 0))]) { item in
////            MapMarker(coordinate: item.coordinate, tint: .red)
////        }
////        .gesture(
////            TapGesture().onEnded { tap in
////                let tappedPoint = tap.location
////                let coordinate = CLLocationCoordinate2D(latitude: tappedPoint.latitude, longitude: tappedPoint.longitude)
////                tappedCoordinate = coordinate
////                print("Tapped at latitude: \(coordinate.latitude), longitude: \(coordinate.longitude)")
////            }
////        )
//    }
//}
//
//struct CustomLocationPicker_Previews: PreviewProvider {
//    static var previews: some View {
//        CustomLocationPicker()
//    }
//}
