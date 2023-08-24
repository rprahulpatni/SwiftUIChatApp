//
//  CustomMapShotView.swift
//  SwiftUIChatApp
//
//  Created by NeoSOFT on 23/08/23.
//

import SwiftUI
import MapKit

struct CustomMapSnapShotView: View {
    @State private var snapshotImage: Image?
    var lat: Double = 37.7749
    var long: Double = -122.4194

    var body: some View {
        VStack {
            if let snapshotImage = snapshotImage {
                snapshotImage
                    .resizable()
                    .scaledToFit()
            } else {
                Text("Loading map snapshot...")
            }
        }
        .onAppear {
            createMapSnapshot()
        }
    }

    func createMapSnapshot() {
        let coordinates = CLLocationCoordinate2D(latitude: lat, longitude: long) // Sample coordinates
        let options = MKMapSnapshotter.Options()

        options.region = MKCoordinateRegion(center: coordinates, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
        options.size = CGSize(width: 250, height: 250) // Specify the size of the snapshot image

        let snapshotter = MKMapSnapshotter(options: options)
        snapshotter.start { snapshot, error in
            if let snapshot = snapshot {
                let image = snapshot.image
                snapshotImage = Image(uiImage: image)
            } else if let error = error {
                print("Error creating map snapshot: \(error.localizedDescription)")
            }
        }
    }
}

struct CustomMapShotView_Previews: PreviewProvider {
    static var previews: some View {
        CustomMapSnapShotView()
    }
}
