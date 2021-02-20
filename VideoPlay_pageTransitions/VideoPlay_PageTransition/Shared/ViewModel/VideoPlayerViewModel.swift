//
//  VideoPlayerViewModel.swift
//  VideoPlay_PageTransition (iOS)
//
//  Created by Ben on 2021/2/20.
//

import SwiftUI
import AVKit

class VideoPlayerViewModel: ObservableObject {
    @Published var showPlayer = false
    @Published var offset: CGSize = .zero
    @Published var scale: CGFloat = 1
    
    @Published var selectedVideo: Video = Video(player: AVPlayer())
}

