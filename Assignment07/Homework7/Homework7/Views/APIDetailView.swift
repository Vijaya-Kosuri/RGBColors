
import Foundation
import SwiftUI

struct APIDetailView: View {
  let apiTask: APIModelEntry
  
  var body: some View {
    VStack {
      Text(apiTask.Auth)
      Text(apiTask.Category)
      Text(apiTask.Cors)
      Text(apiTask.Description)
      Text(apiTask.Link)
    }
    .navigationTitle(apiTask.API)
    .navigationBarTitleDisplayMode(.inline)
    Spacer()
  }
}

