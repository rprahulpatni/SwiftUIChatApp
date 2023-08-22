//
//  CustomVideoPlayerView.swift
//  SwiftUIDemo
//
//  Created by Neosoft on 02/08/23.
//

import SwiftUI
import AVKit

struct CustomVideoPlayerView: View {
    private var player: AVPlayer
    
    init(videoURL: URL) {
        player = AVPlayer(url: videoURL)
    }
    
    var body: some View {
        ZStack {
            VideoPlayer(player: player)
                .edgesIgnoringSafeArea(.all)
                .onAppear {
                    // Play the video when the view appears
                    player.play()
                }
                .onDisappear {
                    // Pause the video when the view disappears
                    player.pause()
                }
        }
    }
}

