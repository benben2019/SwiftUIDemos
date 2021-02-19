//
//  UserData.swift
//  LandMarkDemo
//
//  Created by Ben on 2020/4/20.
//  Copyright © 2020 DoFun. All rights reserved.
//

import Combine
//import SwiftUI

class UserData: ObservableObject {
    @Published var showFavoritesOnly = false
    @Published var landmarks = landmarkData
}

