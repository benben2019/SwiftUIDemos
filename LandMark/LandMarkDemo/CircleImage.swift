//
//  CircleImage.swift
//  LandMarkDemo
//
//  Created by Ben on 2020/4/17.
//  Copyright © 2020 DoFun. All rights reserved.
//

import SwiftUI

struct CircleImage: View {
    
    var image: Image
    
    var body: some View {
//        Image("witcher")
        image
            .resizable()  // 这一句是关键，否则下面一句aspectRatio不生效
            .aspectRatio(contentMode: .fill)
            .frame(width: 200, height: 200)
            .aspectRatio(contentMode: .fit)
            .clipped()
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.white, lineWidth: 4))
            .shadow(radius: 10,x: 10,y: 10)
    }
}

struct CircleImage_Previews: PreviewProvider {
    static var previews: some View {
        CircleImage(image: Image("witcher"))
    }
}
