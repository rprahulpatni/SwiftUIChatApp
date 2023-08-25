//
//  ChatAttachmentDetailsView.swift
//  SwiftUIChatApp
//
//  Created by NeoSOFT on 24/08/23.
//

import SwiftUI
import CoreLocation
import SDWebImageSwiftUI

struct ChatAttachmentDetailsView: View {
    @Binding var lat: Double?
    @Binding var long: Double?
    @Binding var url: URL?
    @Binding var msgType: MessageType?
    @Binding var isDetailScreenPresented: Bool
    @State private var scale: CGFloat = 1.0

    var body: some View {
        ZStack{
            VStack{
                HStack{
                    Spacer()
                    Button("Cancel", role: .cancel, action: {
                        self.isDetailScreenPresented = false
                    })
                }.padding(.horizontal)
                switch msgType {
                case .text:
                    Text("")
                case .picture:
                    GeometryReader { geometry in
                        ScrollView([.horizontal, .vertical]) {
                            WebImage(url: url)
                                .resizable()
//                            CustomSDWebImageView(imgURL: url, imgWidth: UIScreen.main.bounds.width, imgHeight: UIScreen.main.bounds.height - 100, placeholderImage: StringConstants.placeholderImagePerson, isCircle: false)
                                .scaledToFit()
                                .scaleEffect(scale)
                                .gesture(
                                    MagnificationGesture()
                                        .onChanged { value in
                                            scale = value.magnitude
                                        }
                                )
                        }
                        .frame(width: geometry.size.width, height: geometry.size.height)
                    }
                case .video:
                    CustomVideoPlayerView(videoURL: url!)
                case .location:
                    let coordinates = CLLocationCoordinate2D(latitude: lat ?? 0.0, longitude: long ?? 0.0)
                    CustomMapView(coordinate: coordinates)
                case .none:
                    Text("")
                }
            }.padding(.top, 60)
        }.ignoresSafeArea()
    }
}

struct ChatAttachmentDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ChatAttachmentDetailsView(lat: .constant(0.0), long: .constant(0.0), url: .constant(URL(string: "")!), msgType: .constant(.location), isDetailScreenPresented: .constant(false))
    }
}
