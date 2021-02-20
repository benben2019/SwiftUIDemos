//
//  Animation1.swift
//  Animations
//
//  Created by Ben on 2021/2/20.
//

import SwiftUI

struct Language: Identifiable {
    var id: Int
    var name: String
}

struct Animation1: View {
    
    @State var languages: [Language] = [.init(id: 0, name: "Java"),
                                        .init(id: 1, name: "Swift"),
                                        .init(id: 2, name: "Javascript"),
                                        .init(id: 3, name: "Go"),
                                        .init(id: 4, name: "Objective-c"),
                                        .init(id: 5, name: "C++")]
    @State var selectedLanguages: [Language] = []
    @Namespace var namespace
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 15), count: 3),spacing: 15){
                    ForEach(self.languages) { lan in
                        Text(lan.name)
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .frame(width: 110, height: 110)
                            .background(Color.purple.opacity(0.6))
                            .cornerRadius(15)
                            .matchedGeometryEffect(id: lan.id,in: self.namespace)
                            .onTapGesture {
                                self.selectedLanguages.append(lan)
                                self.languages.removeAll { (l) -> Bool in
                                    return l.id == lan.id
                                }
                            }
                    }
                }
                .padding()
                
                HStack {
                    Text("Selected Languages")
                        .font(.title)
                        .fontWeight(.bold)
                    Spacer()
                }
                .padding(.horizontal)
                
                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 15), count: 3),spacing: 15){
                    ForEach(self.selectedLanguages) { lan in
                        Text(lan.name)
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .frame(width: 110, height: 110)
                            .background(Color.blue.opacity(0.6))
                            .cornerRadius(15)
                            .matchedGeometryEffect(id: lan.id,in: self.namespace)
                            .onTapGesture {
                                self.languages.append(lan)
                                self.selectedLanguages.removeAll { (l) -> Bool in
                                    return l.id == lan.id
                                }
                            }
                    }
                }
                .padding()
            }
            .navigationTitle("Languages")
            .navigationBarTitleDisplayMode(.inline)
        }
        .animation(.easeIn)
    }
}

struct Animation1_Previews: PreviewProvider {
    static var previews: some View {
        Animation1()
    }
}
