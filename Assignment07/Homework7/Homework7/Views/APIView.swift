

import Foundation
import SwiftUI

struct APIView: View {
  @State private var apiTasks: [APIModelEntry] = []
  
  
  var body: some View {
    VStack {
      NavigationView {
        List(apiTasks, id: \.id) { apiTask in
          NavigationLink(destination: APIDetailView(apiTask: apiTask)) {
            Text(apiTask.API)
          }
        }
        .navigationTitle("API Tasks")
        .onAppear {
          apiTasks = APIStore.shared.getAPITasks()
        }
      }
    }
  }
  
}


