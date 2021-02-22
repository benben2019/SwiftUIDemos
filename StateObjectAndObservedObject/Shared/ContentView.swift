//
//  ContentView.swift
//  Shared
//
//  Created by Ben on 2021/2/22.
//

import SwiftUI

struct ContentView: View {
    @State private var showRealName = false
    var body: some View {
//        VStack {
//            Button("Toggle Name") {
//                showRealName.toggle()
//            }
//            Text("Current User: \(showRealName ? "Wei Wang" : "onevcat")")
//
//            ScorePlate().padding(.top, 20)
//        }
        NavigationView {
            VStack {
              Button("Toggle Name") {
                showRealName.toggle()
              }
              Text("Current User: \(showRealName ? "Wei Wang" : "onevcat")")
                
              NavigationLink("Next", destination: ScorePlate().padding(.top, 20))
            }
          }
    }
}

class Model: ObservableObject {
    init() { print("Model Created") }
    @Published var score: Int = 0
}

struct ScorePlate: View {
    
//    init() {
//        print("ScorePlate init")
//    }
    
//    @ObservedObject var model = Model()
    @StateObject var model = Model()
    @State private var niceScore = false
    
    var body: some View {
        VStack {
            Button("+1") {
                if model.score > 3 {
                    niceScore = true
                }
                model.score += 1
            }
            Text("Score: \(model.score)")
            Text("Nice? \(niceScore ? "YES" : "NO")")
            
            ScoreText(model: model).padding(.top, 20)
        }
    }
}

struct ScoreText: View {
    
//    init(model: Model) {
//        self.model = model
//        print("ScoreText init")
//    }
    
//    @ObservedObject var model: Model
    @ObservedObject var model: Model  // 这里即使model是从外部传入，但是仍然需要使用@obseredObject或@stateObject的修饰来保持数据同步，否则即便ScoreText每次都被重新创建，ScoreText.body并不会重新渲染。(struct 不可变的原因吧。。。)
    var body: some View {
        if model.score > 10 {
            return Text("Fantastic")
        } else if model.score > 3 {
            return Text("Good")
        } else {
            return Text("Ummmm...")
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
