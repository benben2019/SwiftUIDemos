//
//  PausableRotation.swift
//  CustomMusicPlayer (iOS)
//
//  Created by Ben on 2021/2/22.
//

import SwiftUI

// https://stackoverflow.com/questions/62648245/swiftui-pause-resume-rotation-animation
struct PausableRotation: GeometryEffect {
  
  // this binding is used to inform the view about the current, system-computed angle value
  @Binding var currentAngle: CGFloat
  private var currentAngleValue: CGFloat = 0.0
  
  // this tells the system what property should it interpolate and update with the intermediate values it computed
  var animatableData: CGFloat {
    get { currentAngleValue }
    set { currentAngleValue = newValue }
  }
  
  init(desiredAngle: CGFloat, currentAngle: Binding<CGFloat>) {
    self.currentAngleValue = desiredAngle
    self._currentAngle = currentAngle
  }
  
  // this is the transform that defines the rotation
  func effectValue(size: CGSize) -> ProjectionTransform {
    
    // this is the heart of the solution:
    //   reporting the current (system-computed) angle value back to the view
    //
    // thanks to that the view knows the pause position of the animation
    // and where to start when the animation resumes
    //
    // notice that reporting MUST be done in the dispatch main async block to avoid modifying state during view update
    // (because currentAngle is a view state and each change on it will cause the update pass in the SwiftUI)
    DispatchQueue.main.async {
      self.currentAngle = currentAngleValue
    }
    
    // here I compute the transform itself
    let xOffset = size.width / 2
    let yOffset = size.height / 2
    let transform = CGAffineTransform(translationX: xOffset, y: yOffset)
      .rotated(by: currentAngleValue)
      .translatedBy(x: -xOffset, y: -yOffset)
    return ProjectionTransform(transform)
  }
}
