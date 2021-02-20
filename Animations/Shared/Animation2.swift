//
//  Animation2.swift
//  Animations
//
//  Created by Ben on 2021/2/20.
//

import SwiftUI

struct Animation2: View {
    @Namespace private var namespace
    @State private var isZoomed = false
    @State private var progress: CGFloat = 0

    var imageSize: CGFloat {
        isZoomed ? 300 : 60
    }
    
    var body: some View {
        VStack {
            Spacer()
            
            VStack(spacing: 35) {
                HStack(spacing: 15){
                    Image("zhaolei")
                        .resizable()
                        .frame(width: imageSize, height: imageSize)
                        .cornerRadius(isZoomed ? 5 : 35)
                        .padding(.top, isZoomed ? 35 : 0)
                    
                    if !self.isZoomed {
                        VStack(alignment: .leading, spacing: 5) {
                            Text("南方姑娘")
                                .fontWeight(.bold)
                                .font(.title3)
                            Text("赵雷")
                                .foregroundColor(.red)
                                .font(.subheadline)
                        }
                        .matchedGeometryEffect(id: "detail", in: namespace)
                        
                        Spacer()
                        
                        Button(action: {
                            
                        }, label: {
                            Image(systemName: "play.fill")
                                .font(.title)
                                .foregroundColor(.black)
                        })
                        .matchedGeometryEffect(id: "play", in: namespace)
                    }
                }
                
                if self.isZoomed {
                    
                    VStack(alignment: .center, spacing: 5) {
                        Text("南方姑娘")
                            .fontWeight(.bold)
                            .font(.title3)
                        Text("赵雷")
                            .foregroundColor(.red)
                            .font(.subheadline)
                    }
                    .matchedGeometryEffect(id: "detail", in: namespace)
                    
                    Slider(value: self.$progress)
//                    ProgressView(value: 0.2, total: 1)
                    
                    HStack {
                        Button(action: {
                            
                        }, label: {
                            Image(systemName: "backward.fill")
                                .font(.title)
                                .foregroundColor(.black)
                        })
                        
                        Spacer()
                        
                        Button(action: {
                            
                        }, label: {
                            Image(systemName: "play.fill")
                                .font(.title)
                                .foregroundColor(.black)
                        })
                        .matchedGeometryEffect(id: "play", in: namespace)
                        
                        Spacer()
                        
                        Button(action: {
                            
                        }, label: {
                            Image(systemName: "forward.fill")
                                .font(.title)
                                .foregroundColor(.black)
                        })
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                    
                    HStack {
                        Button(action: {}, label: {
                            Image(systemName: "square.and.arrow.down.fill")
                                .font(.title)
                                .foregroundColor(.black)
                        })
                        Spacer()
                    }
                    .padding([.horizontal,.bottom])
                    
                }
            }
            .padding()
            .background(Color.white.shadow(radius: 3))
            .onTapGesture {
                withAnimation(.easeInOut(duration: 0.4)) {
                    self.isZoomed.toggle()
                }
            }
        }
        .background(Color.black.opacity(0.05))
        .edgesIgnoringSafeArea(.all)
    }
}


struct Animation2_Previews: PreviewProvider {
    static var previews: some View {
        Animation2()
    }
}
