//
//  HomeViewModel.swift
//  CustomMusicPlayer (iOS)
//
//  Created by Ben on 2021/2/22.
//

import SwiftUI
import AVKit


let url = URL(fileURLWithPath: Bundle.main.path(forResource: "Chill Day", ofType: "mp3")!)

class HomeViewModel: ObservableObject {
    
    @Published var player = try! AVAudioPlayer(contentsOf: url)
    @Published var isPlaying = false
    @Published var album = Album()
    @Published var angle: Double = 0
    @Published var volume: CGFloat = 0
    
    func fetchAlbum() {
        let asset = AVAsset(url: player.url!)
        
        print(asset.metadata.count)
        
        asset.metadata.forEach { (item) in
            print(item.commonKey?.rawValue as Any)
            
            switch item.commonKey?.rawValue {
            case "title":
                album.title = item.value as? String ?? ""
            case "artist":
                album.artist = item.value as? String ?? ""
            case "type":
                album.type = item.value as? String ?? ""
            case "artwork":
                if item.value != nil { album.artwork = UIImage(data: item.value as! Data)! }
            default: ()
            }
        }
        
        volume = CGFloat(player.volume) * (UIScreen.main.bounds.width - 180)
    }
    
    func onChanged(value: DragGesture.Value) {
        
//        print(value.location)
        
        let vector = CGVector(dx: value.location.x, dy: value.location.y)
        
        let radians = atan2(vector.dy - 12.5, vector.dx - 12.5)
        let temAngle = radians * 180 / .pi
        
        let angle = temAngle < 0 ? 360 + temAngle : temAngle
        
//        print("vector: \(vector) -- radians: \(radians) -- temAngle: \(temAngle) -- angle: \(angle)")
        
        if angle < 0.8 * 360/* 288 */ {
            
            let progress = angle / 288
            let curTime = TimeInterval(progress) * player.duration
            player.currentTime = curTime
            player.play()
            
            withAnimation(Animation.linear(duration: 0.1)) {
                self.angle = Double(angle)
            }
        }
    }
    
    func updateTimer() {
        let curTime = player.currentTime
        let total = player.duration
        let progress = curTime / total
        
        withAnimation(Animation.linear(duration: 0.1)) {
            self.angle = Double(progress) * 360 * 0.8 
        }
        isPlaying = player.isPlaying
    }
    
    func getCurrentTime(value: TimeInterval) -> String {
        let a = "\(Int(value / 60))"
        let b = String(format: "%02d",Int(value.truncatingRemainder(dividingBy: 60)))
        return a + ":" + b
    }
    
    func play() {
        if isPlaying {
            player.pause()
        } else {
            player.play()
        }
        
        isPlaying = player.isPlaying
    }
    
    func updateVolume(value: DragGesture.Value) {
        
        if value.location.x >= 0 && value.location.x <= UIScreen.main.bounds.width - 180 {
            
            let progress = value.location.x / (UIScreen.main.bounds.width - 180)
            player.volume = Float(progress)
            withAnimation(Animation.linear(duration: 0.1)) {
                volume = value.location.x
            }
        }
    }
}
