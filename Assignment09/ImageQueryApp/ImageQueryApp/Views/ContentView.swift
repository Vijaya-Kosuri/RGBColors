import SwiftUI
import Foundation

@MainActor
struct ContentView: View {
  @ObservedObject private var pexelStore = PexelStore.shared
  @State private var photos: [PexelsPhoto] = []
  @State private var searchText = ""
  @State private var selectedPhoto: PexelsPhoto? = nil
  @State private var isImageDetailViewPresented = false
  
  var body: some View {
    
    VStack{
      SearchBar(text: $searchText, placeholder: "Search for photos")
      List(photos, id: \.id) { photo in
        Text(photo.url)
          .onTapGesture {
            selectedPhoto = photo
            isImageDetailViewPresented.toggle()
          }
      }
      .onAppear {
        searchPhotos()
      }
      .onChange(of: searchText) {
        searchPhotos()
      }
      .sheet(item: $selectedPhoto) { photo in
        ImageView(photo: photo, onClose: {
          selectedPhoto = nil
        })
      }
    }
  }
  
  struct SearchBar: View {
    @Binding var text: String
    var placeholder: String
    
    var body: some View {
      HStack {
        TextField(placeholder, text: $text)
          .padding(8)
          .background(Color(.systemGray5))
          .cornerRadius(8)
          .padding([.leading, .trailing], 8)
      }
      .padding()
    }
  }
  
  private func searchPhotos() {
    PexelStore.shared.fetchPhotos(query: searchText, page: 1, perPage: 1) { result in
      switch result {
      case .success(let response):
        DispatchQueue.main.async {
          self.photos = response.photos
        }
      case .failure(let error):
        print("Error fetching photos: \(error)")
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}

