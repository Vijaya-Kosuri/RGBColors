

import Foundation
import SwiftUI

struct APIView: View {
  @State private var apiTasks: [APIModelEntry] = []
  @State private var isLoading = true
  @State private var downloadProgress: Float = 0.0
  
  @ObservedObject var apiStore = APIStore.shared
  
  
  var body: some View {
    VStack {
      
      if apiStore.loading {
        ProgressBar(progress: $apiStore.downloadProgress)
          .frame(height: 10)
          .padding()
      }
      else {
        NavigationView {
          List(apiTasks, id: \.id) { apiTask in
            NavigationLink(destination: APIDetailView(apiTask: apiTask)) {
              Text(apiTask.API)
            }
          }
          .alert(isPresented: $apiStore.showAlert) {
            Alert(title: Text("Error!!"), message: Text("Failed to load API data."), dismissButton: .default(Text("OK")))
          }
          .navigationTitle("API Tasks")
          .onAppear {
            apiTasks = apiStore.getAPITasks()
            isLoading = false
            apiStore.$downloadProgress
              .assign(to: \.downloadProgress, on: self)
          }
          
        }
      }
    }
  }
  
  
}



