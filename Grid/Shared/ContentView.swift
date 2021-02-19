//
//  ContentView.swift
//  Shared
//
//  Created by Ben on 2021/2/19.
//

import SwiftUI
//import AVKit
//import MapKit

struct ContentView: View {
    
    var messages: [Message] = [.init(id: 0, msg: "init")]
    
    var body: some View {
        Text("hello world")
    }
}

struct Home: View {
    @State var columns: [GridItem] = [
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10)
    ]
    @State var messages: [Message] = [.init(id: 0, msg: "init")]
    @State var message: String = ""
    
    @State var show: Bool = false
//    @State var region = MKCoordinateRegion(center: .init(latitude: 13, longitude: 80), latitudinalMeters: 1000, longitudinalMeters: 1000)
    @State var txt: String = ""
    @State var expanded: Bool = false
    @State var selectedCity: String = "1"
    @State var query: String = ""
    var results: [String] = ["fsfdfd","45455","bbbbb","cccBbbC","people","country"]
    @State var searchResults: [String] = []
    
    var body: some View {
        
        // MARK: Grid
//        VStack {
//            LazyVGrid(columns: columns) {
//                ForEach(0...10,id: \.self) {index in
//                    Text("\(index)")
//                        .fontWeight(.bold)
//                        .font(.title)
//                        .frame(width: 40,height: 40)
//                        .padding()
//                        .background(Color.red.opacity(0.8))
//                }
//            }
//        }

        
        // MARK: ScrollView自动滚动到最后
//        VStack {
//            ScrollView {
//                ScrollViewReader {reader in
//                    ForEach(messages) {msg in
//                        HStack {
//                            Text(msg.msg)
//                            Spacer()
//                        }
//                        .padding()
//                        .onAppear {
//                            withAnimation(.default) {
//                                reader.scrollTo(messages.count - 1)
//                            }
//                        }
//                    }
//                }
//            }
//
//            HStack(spacing: 15) {
//                TextField("enter a message", text: $message)
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
//
//                Button("Send") {
//                    self.messages.append(Message(id: self.messages.count, msg: self.message))
//                    self.message = ""
//                }
//            }
//            .padding()
//        }

        // MARK: page View
//        TabView {
//            Color.red
//                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
//            Color.yellow
//                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
//            Color.blue
//                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
//        }
//        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
        
        // MARK: full screen modal
//        VStack {
//            Button("Full Screen Modal") {
//                self.show.toggle()
//            }
//        }
//        .fullScreenCover(isPresented: self.$show) {
//            ZStack(alignment: .topTrailing, content: {
//                Color.gray
//                Button(action: {
//                    self.show.toggle()
//                }, label: {
//                    Image(systemName: "xmark")
//                        .foregroundColor(.white)
//                })
//                .padding()
//            })
//        }
        
        // MARK: AVKit video player
//        VideoPlayer(player: AVPlayer(url: URL(string: "https://sf1-scmcdn-tos.pstatp.com/goofy/ies/douyin_home_web/medias/banner_video1.4c74cc4e.mp4")!))
//            .frame(height: 200)
//            .cornerRadius(10)
//            .padding(.horizontal)
        
        // MARK: map
//        Map(coordinateRegion: self.$region)
//            .frame(height: 500)
//            .cornerRadius(20)
//            .padding(.horizontal)
        
        // MARK: webLink
//        Link(destination: URL(string: "https://www.apple.com")!, label: {
//            Text("Apple")
//        })
        
        // MARK:  progressView
//        ProgressView(value: 0.6, total: 1.0) {
//            Text("111")
//        }
//        .progressViewStyle(CircularProgressViewStyle(tint: .red))
//        .padding()
        
        // MARK: textEditor
//        TextEditor(text: self.$txt)
//            .frame(height: 200)
////            .cornerRadius(10)
////            .border(Color.black, width: 1)
//            .padding(.horizontal)
//            .overlay( // 同时设置描边和圆角的正确方式
//                RoundedRectangle(cornerRadius: 10)
//                    .stroke()
//            )
//            .padding(.horizontal)
        
        
        // MARK: DisclosureGroup
//        VStack {
//            DisclosureGroup("Pick a city", isExpanded: self.$expanded) {
//                ScrollView{
//                    LazyVStack(alignment: .leading, spacing: 10, pinnedViews: /*@START_MENU_TOKEN@*/[]/*@END_MENU_TOKEN@*/, content: {
//                        ForEach(1...100, id: \.self) { i in
//                            Text("city_\(i)")
//                                .padding()
//                                .onTapGesture {
//                                    withAnimation(.default) {
//                                        self.selectedCity = i.description
//                                        self.expanded.toggle()
//                                    }
//                                }
//                        }
//                    })
//                }
//                .frame(height: 200)
//            }
//            .padding()
//            .background(Color.gray.opacity(0.3))
//            .cornerRadius(10)
//            .padding(.horizontal)
//
//            Text("selected city: \(self.selectedCity)")
//                .padding(.all,10)
//
//            Spacer()
//        }

        // MARK: searchBar
        VStack {
            HStack(spacing: 15){
                TextField("search", text: self.$query)
                    .autocapitalization(.none)
                    .onChange(of: self.query, perform: { inputValue in
                        if inputValue.count == 0 {
                            self.searchResults.removeAll()
                            return
                        }
                        DispatchQueue.global(qos: .background).async {
                            let r = self.results.filter{$0.lowercased().contains(inputValue.lowercased())}
                            DispatchQueue.main.async {
                                self.searchResults = r
                            }
                        }
                    })
                
                if self.query.count > 0 {
                    Button(action: {
                        self.query = ""
                    }, label: {
                        Image(systemName: "xmark")
                            .foregroundColor(.black)
                    })
                }
         
            }
            .padding(.all)
            .background(Color.gray.opacity(0.3))
            .cornerRadius(15)
            .padding([.horizontal,.top])
            
            List(self.searchResults,id: \.self) {result in
                Text(result)
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
//            ContentView()
            Home()
        }
    }
}

struct Message: Identifiable {
    var id: Int
    var msg: String
}
