//
//  VideoPreview.swift
//  VideoPlay_PageTransition (iOS)
//
//  Created by Ben on 2021/2/20.
//

import SwiftUI
import AVKit

struct VideoPreview: UIViewControllerRepresentable {
    
    var player: AVPlayer
    
    func makeUIViewController(context: Context) -> AVPlayerViewController {
        
        let avPlayController = AVPlayerViewController()
        avPlayController.player = player
        avPlayController.videoGravity = .resizeAspectFill
        avPlayController.showsPlaybackControls = false
        return avPlayController
    }
    
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
        
    }
}


