//
//  LandmarkList.swift
//  LandMarkDemo
//
//  Created by Ben on 2020/4/17.
//  Copyright © 2020 DoFun. All rights reserved.
//

import SwiftUI

struct LandmarkList: View {
    var body: some View {
        
        NavigationView {
            List(landmarkData /*,id: \.id */) { landmark in
                
                NavigationLink(destination: LandmarkDetail(landmark: landmark)) {
                    LandmarkRow(landmark: landmark)
                }
                
            }
            .navigationBarTitle(Text("Landmarks"))
        }
    }
}

struct LandmarkList_Previews: PreviewProvider {
    static var previews: some View {
        
//        ForEach(["iPhone se","iPhone 11 pro"], id: \.self) { deviceName in
//
//        }
        ForEach(["iPhone SE", "iPhone XS Max"], id: \.self) { deviceName in
            LandmarkList()
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
        }
//        LandmarkList()
//        .previewDevice(PreviewDevice(rawValue: "iPhone SE"))
    }
}
