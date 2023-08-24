//
//  CustomLocationPicker.swift
//  SwiftUIChatApp
//
//  Created by NeoSOFT on 22/08/23.
//

import SwiftUI
import MapKit

//struct CustomLocationPicker: View {
//    @State private var selectedCoordinate: CLLocationCoordinate2D?
//    @State private var isMapViewVisible = false
//
//    var body: some View {
//        VStack {
//            if isMapViewVisible {
//                MapView(selectedCoordinate: $selectedCoordinate)
//            } else {
//                Button("Pick Location") {
//                    isMapViewVisible.toggle()
//                }
//            }
//
//            if let selectedCoordinate = selectedCoordinate {
//                Button("Send to Firebase") {
//                    sendCoordinatesToFirebase(selectedCoordinate)
//                }
//            }
//        }
//    }
//
//    func sendCoordinatesToFirebase(_ coordinate: CLLocationCoordinate2D) {
//        // Send the coordinates to Firebase
//        // Replace this with your Firebase code
//        // Example:
//        // let coordinatesRef = Database.database().reference().child("user_coordinates")
//        // let userUID = Auth.auth().currentUser?.uid ?? ""
//        // coordinatesRef.child(userUID).setValue([
//        //     "latitude": coordinate.latitude,
//        //     "longitude": coordinate.longitude
//        // ])
//    }
//}
//
//struct CustomLocationPicker_Previews: PreviewProvider {
//    static var previews: some View {
//        CustomLocationPicker()
//    }
//}
//
//struct MapView: View {
//    @Binding var selectedCoordinate: CLLocationCoordinate2D?
//
//    var body: some View {
//        Map(
//            coordinateRegion: .constant(
//                MKCoordinateRegion(
//                    center: selectedCoordinate ?? CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
//                    span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
//                )
//            ),
//            interactionModes: .all,
//            showsUserLocation: true,
//            userTrackingMode: .constant(.follow),
//            annotationItems: [selectedCoordinate].compactMap { $0 }
//        ) { coordinate in
//            MapPin(coordinate: coordinate)
//        }
////        .onTapGesture { tapCoordinate in
////            selectedCoordinate = tapCoordinate
////        }
//    }
//}
