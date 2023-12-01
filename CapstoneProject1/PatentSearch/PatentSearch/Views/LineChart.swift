//
//  LineChart.swift
//  PatentSearch
//
//  Created by Srinivas Pala on 11/19/23.
//

import Foundation
import SwiftUI
import Charts

struct LineChart: View {
    let dataPoints: [Double]
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.horizontal) {
                VStack {
                    drawChart(in: geometry)
                }
                //.overlay(drawAxes(in: geometry), alignment: .topLeading)
            }
        }
    }
    
    private func drawChart(in geometry: GeometryProxy) -> some View {
        Path { path in
            let width = geometry.size.width
            let height = geometry.size.height
            
            guard dataPoints.count > 1,
                  let minData = dataPoints.min(),
                  let maxData = dataPoints.max() else {
                return
            }
            
            let xStep = width / CGFloat(dataPoints.count - 1)
            let yScale = height / CGFloat(maxData - minData)
            
            for (index, data) in dataPoints.enumerated() {
                let x = CGFloat(index) * xStep
                let y = height - CGFloat(data - minData) * yScale
                
                if index == 0 {
                    path.move(to: CGPoint(x: x, y: y))
                } else {
                    path.addLine(to: CGPoint(x: x, y: y))
                }
            }
        }
        .stroke(Color.blue, lineWidth: 2)
        .background(Rectangle().fill(Color.white))
    }
    
  private func drawAxes(in geometry: GeometryProxy) -> some View {
      VStack {
          Spacer()

          // X-axis
          //Rectangle()
          //.frame(width: 1, height: geometry.size.height)
          //.frame(width: geometry.size.width, height: 1)
             // .background(Color.black)
      }
  }
}
