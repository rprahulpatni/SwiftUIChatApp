//
//  CustomRatingView.swift
//  SwiftUIDemo
//
//  Created by Neosoft on 17/07/23.
//

import SwiftUI

struct CustomRatingView: View {
    let rating: Double

    var body: some View {
        HStack(spacing: 1) {
            ForEach(1...5, id: \.self) { index in
                image(for: index)
                    .foregroundColor(color(for: index))
            }
        }
    }

    private func image(for index: Int) -> Image {
        let fillThreshold = Double(index) - 0.5

        if rating >= Double(index) {
            return Image(systemName: "star.fill")
        } else if rating >= fillThreshold {
            return Image(systemName: "star.leadinghalf.fill")
        } else {
            return Image(systemName: "star")
        }
    }

    private func color(for index: Int) -> Color {
        if rating >= Double(index) {
            return .yellow
        } else {
            return .gray
        }
    }
}

struct CustomRatingView_Previews: PreviewProvider {
    static var previews: some View {
        CustomRatingView(rating: 4.5)
    }
}
