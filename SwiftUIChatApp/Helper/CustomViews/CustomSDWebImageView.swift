//
//  CustomSDWebImageView.swift
//  MovieDBSwiftUI
//
//  Created by Neosoft on 25/07/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct CustomSDWebImageView: View {
    var imgURL: URL?
    var imgWidth: CGFloat?
    var imgHeight: CGFloat?
    var placeholderImage: String?
    var isCircle: Bool
    var cornerRadius: CGFloat = 0

    var body: some View {
        //For displaying Movie Image
        //Using SDWebImageView for displaying image with cache, placeholder
        WebImage(url: imgURL).placeholder{
            Image(systemName: placeholderImage ?? "person.circle.fill")
                .resizable()
                .foregroundColor(.black)
                .frame(width: imgWidth, height: imgHeight)
                .background(.gray.opacity(0.6))
        }
        .resizable()
        .indicator(.activity)
        .transition(.fade)
        .aspectRatio(contentMode: .fill)
        .frame(width: imgWidth, height: imgHeight)
        .clipped()
        .background(.thinMaterial)
        .cornerRadius(isCircle == true ? imgHeight! / 2 : cornerRadius)
    }
}

struct ZoomableImageView: View {
    @State private var scale: CGFloat = 1.0

    var body: some View {
        GeometryReader { geometry in
            ScrollView([.horizontal, .vertical]) {
                Image("your_image_name")
                    .resizable()
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
    }
}
