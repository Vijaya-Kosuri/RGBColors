
import Foundation

import SwiftUI

struct ProgressBar: View {
  @Binding var progress: Float
  
  var body: some View {
    GeometryReader { geometry in
      ZStack(alignment: .center ) {
        Rectangle()
          .foregroundColor(Color.red.opacity(0.3))
          .frame(width: geometry.size.width, height: 8)
        
        Rectangle()
          .foregroundColor(Color.blue)
          .frame(width: min(CGFloat(self.progress) * geometry.size.width, geometry.size.width), height: 8)
          .animation(.linear)
      }
    }
    .cornerRadius(4)
    .padding(.horizontal)
  }
}
