
import Foundation

import SwiftUI

struct ImageView: View {
  let photo: PexelsPhoto
  let onClose: () -> Void
  @Environment(\.presentationMode) private var presentationMode
  @ObservedObject private var pexelStore = PexelStore.shared
  @State private var downloadProgress: Float = 0.0
  
  var body: some View {
    VStack {
      HStack {
        Spacer()
        Button("Back") {
          onClose()
        }
        Spacer()
      }
      Text("Image View: \(photo.url)")
      AsyncImage(url: URL(string: photo.src.large2x)) { image in
        image
          .resizable()
          .aspectRatio(contentMode: .fit)
      }
    placeholder: {
      ProgressView(value: downloadProgress)
        .progressViewStyle(LinearProgressViewStyle())
        .padding(.top, 40)
        .padding(.horizontal, 20)
    }
    }
    .padding()
    .onAppear {
      downloadImage()
    }
  }
  
  
  private func downloadImage() {
    let totalSteps = 100
    for step in 0..<totalSteps {
      DispatchQueue.main.asyncAfter(deadline: .now() + Double(step) * 0.1) {
        downloadProgress = Float(step + 1) / Float(totalSteps)
      }
    }
    DispatchQueue.main.asyncAfter(deadline: .now() + Double(totalSteps) * 0.1) {
      onClose()
    }
  }
}
