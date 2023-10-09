//
//  ContentView.swift
//  Animation
//
//  Created by Srinivas Pala on 10/4/23.
//

import SwiftUI

struct ContentView: View {
  private struct AnimationData : Equatable {
    let offset: CGSize
    let color: Color
    
    static let array: [Self] = [
      .init(
      offset: .init(width: 0,height: 0), color: .green),
      .init(
      offset: .init(width: 100,height: 0), color: .blue),
      .init(
      offset: .init(width: 100,height: -100), color: .red),
      .init(
      offset: .init(width: -100,height: -100), color: .orange),
      .init(
      offset: .init(width: -100,height: 0), color: .yellow)
    ]
  }
  
  
  @State private var animationData = AnimationData.array[0]
    var body: some View {

      Circle()
        .scaleEffect(0.5)
        .foregroundColor(animationData.color)
        .animation(.default, value: animationData )
        .offset(animationData.offset)
        .padding()
        .onAppear() {
          for(index, data) in AnimationData.array.enumerated().dropFirst(){
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(index)) {
              animationData = data
            }
          }
        }
    }
}

#Preview {
    ContentView()
}
