//
//  Home.swift
//  VideoPlay_PageTransition (iOS)
//
//  Created by Ben on 2021/2/20.
//

import SwiftUI

struct Home: View {
    
    @Environment(\.colorScheme) var scheme
    let columns: [GridItem] = Array(repeating: GridItem(.flexible(), spacing: 15), count: 2)
    
    @StateObject var playerModel = VideoPlayerViewModel()
    @Namespace var animation
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Button(action: {}, label: {
                        Image(systemName: "person.fill")
                            .font(.system(size: 22))
                            .foregroundColor(.pink)
                    })
                    Button(action: {}, label: {
                        Image(systemName: "magnifyingglass")
                            .font(.system(size: 22))
                            .foregroundColor(.primary)
                    })
                    
                    Spacer()
                    
                    Button(action: {}, label: {
                        Image(systemName: "person.badge.plus.fill")
                            .font(.system(size: 22))
                            .foregroundColor(.primary)
                    })
                }
                .padding(.horizontal)
                .padding(.vertical,10)
                .overlay(
                    Text("Discover")
                        .fontWeight(.bold)
                        .font(.title2)
                        .foregroundColor(.primary)
                )
                .background(scheme == .dark ? Color.black : Color.white)
                .shadow(color: Color.primary.opacity(0.08), radius: 5, x: 0, y: 5)
                
                ScrollView {
                    LazyVGrid(columns: columns) {
                        ForEach(videos) { video in
                            VideoPreview(player: video.player)
                                .cornerRadius(10)
                                .matchedGeometryEffect(id: video.id, in: animation)
                                .scaleEffect(playerModel.showPlayer && playerModel.selectedVideo.id == video.id ? playerModel.scale : 1)
                                .frame(height: 280)
                                .onTapGesture {
                                    playerModel.showPlayer = true
                                    playerModel.selectedVideo = video
                                }
                                .zIndex(0)
                        }
                    }
                    .padding()
                }
            }
            
            if playerModel.showPlayer {
                VideoPreview(player: playerModel.selectedVideo.player)
                    .cornerRadius(10)
                    .scaleEffect(playerModel.scale)
                    .matchedGeometryEffect(id: playerModel.selectedVideo.id, in: animation)
                    .offset(playerModel.offset)
                    .gesture(DragGesture()
                                .onChanged(onChanged(value:))
                                .onEnded(onEnd(value:)))
                    .onAppear(perform: {
                        playerModel.selectedVideo.player.play()
                    })
                    .ignoresSafeArea()
                    .zIndex(3)
            }
        }
    }
    
    private func onChanged(value: DragGesture.Value) {
        
        if value.translation.height > 0 { // 向下拖
            playerModel.offset = value.translation
        }
        
        let progress = playerModel.offset.height / UIScreen.main.bounds.size.height
        if 1 - progress > 0.5 {
            playerModel.scale = 1 - progress
        }
    }
    private func onEnd(value: DragGesture.Value) {
        
        withAnimation {
            
            if value.translation.height > 300 {
                playerModel.selectedVideo.player.pause()
                playerModel.showPlayer = false
            }
            
            playerModel.offset = .zero
            playerModel.scale = 1
        }
    }
    
    
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
