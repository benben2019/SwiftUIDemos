//
//  Video.swift
//  VideoPlay_PageTransition (iOS)
//
//  Created by Ben on 2021/2/20.
//

import SwiftUI
import AVKit

struct Video: Identifiable {
    var id = UUID().uuidString
    var player: AVPlayer
}

fileprivate func getFileUrl(fileName: String) -> URL {
    let path = Bundle.main.path(forResource: fileName, ofType: "MP4")
    return URL(fileURLWithPath: path!)
}


var videos = [
    Video(player: AVPlayer(url: getFileUrl(fileName: "video1"))),
    Video(player: AVPlayer(url: getFileUrl(fileName: "video2"))),
    Video(player: AVPlayer(url: getFileUrl(fileName: "video3"))),
    Video(player: AVPlayer(url: getFileUrl(fileName: "video4"))),
    Video(player: AVPlayer(url: getFileUrl(fileName: "video5")))
]
