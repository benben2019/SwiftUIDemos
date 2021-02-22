//
//  Home.swift
//  CustomMusicPlayer (iOS)
//
//  Created by Ben on 2021/2/22.
//

import SwiftUI

struct Home: View {
    
    @StateObject var homeViewModel = HomeViewModel()
    @State private var width: CGFloat = UIScreen.main.bounds.height < 750 ? 130: 230
    @State private var timer = Timer.publish(every: 0.5, on: .current, in: .default).autoconnect()
    
    @State private var desiredAngle: CGFloat = 0.0
    @State private var currentAngle: CGFloat = 0.0
    
    private var foreverAnimation: Animation {
        Animation.linear(duration: 10)
          .repeatForever(autoreverses: false)
      }
    
    var body: some View {
        VStack {

            HStack {
                Button(action: {}, label: {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                        .foregroundColor(.black)
                })
                
                Spacer(minLength: 0)
                
                Button(action: {}, label: {
                    Image(systemName: "magnifyingglass")
                        .font(.title2)
                        .foregroundColor(.black)
                })
            }
            .padding()
            
            VStack {
                Spacer(minLength: 0)
                
                ZStack {
                    Image(uiImage: homeViewModel.album.artwork)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: width, height: width)
                        .clipShape(Circle())
                        .modifier(PausableRotation(desiredAngle: desiredAngle, currentAngle: $currentAngle))
    //                    .rotationEffect(Angle.degrees(homeViewModel.isPlaying ? 360 : 0))
    //                    .animation(homeViewModel.isPlaying ? Animation.linear(duration: 15)
    //                                    .repeatForever(autoreverses: false) : .default)
                    
                    ZStack {
                        Circle()
                            .trim(from: 0, to: 0.8)
                            .stroke(Color.black.opacity(0.06),lineWidth: 4)
                            .frame(width: width + 45, height: width + 45)
                        
                        Circle()
                            .trim(from: 0, to: CGFloat(homeViewModel.angle) / 360)
                            .stroke(Color.orange,lineWidth: 4)
                            .frame(width: width + 45, height: width + 45)
                        
                        Circle()
                            .fill(Color.orange)
                            .frame(width: 25,height: 25)
                            .offset(x: (width + 45) / 2)
                            .rotationEffect(.init(degrees: homeViewModel.angle))
                            .gesture(DragGesture()
                                        .onChanged(homeViewModel.onChanged(value:)))
                    }
                    .rotationEffect(.init(degrees: 90 + 36))
                    
                    Text(homeViewModel.getCurrentTime(value: homeViewModel.player.currentTime))
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                        .offset(x: UIScreen.main.bounds.size.height < 750 ? -65 : -85, y: (width + 60) / 2)
                    
                    Text(homeViewModel.getCurrentTime(value: homeViewModel.player.duration))
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                        .offset(x: UIScreen.main.bounds.size.height < 750 ? 65 : 85, y: (width + 60) / 2)
                }
                
                Text(homeViewModel.album.title)
                    .fontWeight(.heavy)
                    .font(.title2)
                    .foregroundColor(.black)
                    .padding(.top,25)
                    .padding(.horizontal)
                    .lineLimit(1)
                
                Text(homeViewModel.album.artist)
                    .foregroundColor(.gray)
                    .padding(.top,5)
                
                HStack(spacing: 55) {
                    Button(action: {}, label: {
                        Image(systemName: "backward.fill")
                            .font(.title)
                            .foregroundColor(.gray)
                    })
                    
                    Button(action: {
                        homeViewModel.play()
                        let startAngle = currentAngle.truncatingRemainder(dividingBy: CGFloat.pi * 2)
                        let angleDelta = homeViewModel.isPlaying ? CGFloat.pi * 2 : 0.0
                        withAnimation(homeViewModel.isPlaying ? foreverAnimation : .linear(duration: 0)) {
                            self.desiredAngle = startAngle + angleDelta
                        }
                    }) {
                        Image(systemName: homeViewModel.isPlaying ? "pause.fill" : "play.fill")
                            .font(.title)
                            .foregroundColor(.white)
                            //                        .padding()
                            .frame(width: 60, height: 60)
                            .background(Color.orange)
                            .clipShape(Circle())
                    }
                    
                    Button(action: {}, label: {
                        Image(systemName: "forward.fill")
                            .font(.title)
                            .foregroundColor(.gray)
                    })
                }
                .padding(.top,25)
                
                HStack(spacing: 15) {
                    Image(systemName: "minus")
                        .foregroundColor(.black)
                    
                    ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
                        Capsule()
                            .fill(Color.black.opacity(0.06))
                            .frame(height: 4)
                        
                        Capsule()
                            .fill(Color.orange)
                            .frame(width: homeViewModel.volume,height: 4)
                        
                        Circle()
                            .fill(Color.orange)
                            .frame(width: 20, height: 20)
                            .offset(x: homeViewModel.volume)
                            .gesture(DragGesture()
                                        .onChanged(homeViewModel.updateVolume(value:)))
                    }
                    .frame(width: UIScreen.main.bounds.width - 160)
                    
                    Image(systemName: "plus")
                        .foregroundColor(.black)
                }
                .padding(.top,45)
                .padding(.horizontal)
                .padding(.bottom,5)
                
                Spacer(minLength: 0)
                
            }
            .frame(maxWidth: .infinity)
            .background(Color.white)
            .cornerRadius(35)
        }
        .background(
            VStack {
                Color.pink.opacity(0.2)
                Color.blue.opacity(0.3)
            }
            .ignoresSafeArea()
        )
        .onAppear(perform: homeViewModel.fetchAlbum)
        .onReceive(timer, perform: { _ in
            homeViewModel.updateTimer()
        })
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
            
    }
}
