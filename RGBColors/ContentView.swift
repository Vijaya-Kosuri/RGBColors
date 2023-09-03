//
//  ContentView.swift
//  RGBColors
//

import SwiftUI

struct ContentView: View {
  
  //@State properties to track the slider color. Initialize to color mentioned in the assignment
  @State private var sliderValueRed  = 99.0
  @State private var sliderValueGreen  = 40.0
  @State private var sliderValueBlue  = 75.0
  
  //Generate the color based on the values
  @State private var fillColor: Color = Color(red: 99/255, green: 40/255, blue: 75/255)
  
  var body: some View {
    
    //VStack of text, roundedrectangle, texts, sliders
    VStack {
      Text("Color Picker").font(.largeTitle)
      
      RoundedRectangle(cornerRadius: 0).fill(fillColor).padding(.horizontal, 30).frame(width: 400, height: 300)
      
      Text("Red").bold()
      HStack { //Hstack of slider and the text
        Slider(value: $sliderValueRed,in: 0...255).padding(.leading, 20).padding(.trailing, -20)
        Text(String(Int(sliderValueRed))).padding(.horizontal, 20)
      }
      
      Text("Green").bold()
      HStack {
        Slider(value: $sliderValueGreen,in: 0...255).padding(.leading, 20).padding(.trailing, -20)
        Text(String(Int(sliderValueGreen))).padding(.horizontal, 20)
      }
      
      Text("Blue").bold()
      HStack {
        Slider(value: $sliderValueBlue,in: 0...255).padding(.leading, 20).padding(.trailing, -20)
        Text(String(Int(sliderValueBlue))).padding(.horizontal, 20)
      }
      
      Button(action: { //Button to perform the action of setting the coloer based on the slidervalues
        fillColor = Color(red: sliderValueRed/255, green: sliderValueGreen/255, blue: sliderValueBlue/255)
      }) {
        Text("Set Color").bold()
      }
      
    }
    
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
