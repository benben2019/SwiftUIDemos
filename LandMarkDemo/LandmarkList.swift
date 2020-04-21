//
//  LandmarkList.swift
//  LandMarkDemo
//
//  Created by Ben on 2020/4/17.
//  Copyright © 2020 DoFun. All rights reserved.
//

import SwiftUI

struct LandmarkList: View {
    
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        
        NavigationView {
            List {
                
                Toggle(isOn: $userData.showFavoritesOnly) {
                    Text("Show Favorites Only")
                }
                
                ForEach(userData.landmarks) { landmark in
                    if !self.userData.showFavoritesOnly || landmark.isFavorite {
                        
                        NavigationLink(destination: LandmarkDetail(landmark: landmark).environmentObject(self.userData)) {
                            LandmarkRow(landmark: landmark)
                        }
                        
                    }
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
//        ForEach([/*"iPhone SE", */"iPhone XS Max"], id: \.self) { deviceName in
            LandmarkList()
        .environmentObject(UserData())
//                .previewDevice(PreviewDevice(rawValue: deviceName))
//                .previewDisplayName(deviceName)
//        }
//        LandmarkList()
//        .previewDevice(PreviewDevice(rawValue: "iPhone SE"))
    }
}
