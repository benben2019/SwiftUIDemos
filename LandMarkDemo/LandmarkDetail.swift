//
//  ContentView.swift
//  LandMarkDemo
//
//  Created by Ben on 2020/4/17.
//  Copyright © 2020 DoFun. All rights reserved.
//

import SwiftUI

struct LandmarkDetail: View {
    
    var landmark: Landmark
    
    var body: some View {
        VStack {
            MapView(coordinate: landmark.locationCoordinate)
            .edgesIgnoringSafeArea(.top)
                .frame(height: 300)
            
            CircleImage(image: landmark.image)
                .offset(y: -100)
                .padding(.bottom, -100)
            
            VStack(alignment: .leading) {
                Text(landmark.name)
                    .font(.title)
                HStack(alignment: .firstTextBaseline) {
                    Text(landmark.park)
                        .italic()
                        .font(.footnote)
                    Spacer()
                    Text(landmark.state)
                        .font(.system(size: 10))
                }
            }
            .padding([.horizontal])
            
            Spacer()
        }
        .navigationBarTitle(Text(landmark.name),displayMode: .inline)
    }
}

struct LandmarkDetail_Previews: PreviewProvider {
    static var previews: some View {
        LandmarkDetail(landmark: landmarkData[0])
    }
}
