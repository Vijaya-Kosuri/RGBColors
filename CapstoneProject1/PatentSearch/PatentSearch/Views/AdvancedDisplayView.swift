

import Foundation
import SwiftUI

struct AdvancedDisplayView: View {
    var results: [OrganicResult]
  @State private var searchText = ""
  //@State private var results: [OrganicResult] = []
  @State private var selectedresult: OrganicResult? = nil
  @State private var isImageDetailViewPresented = false
  let placeholderImage = Image(systemName: "photo")

    var body: some View {
      
      List(results, id: \.id) { result in
        VStack(alignment: .leading, spacing: 8) {
          HStack(alignment: .top, spacing: 8) {
            
            if let firstFigure = result.figures?.first,
               let thumbnailURL = URL(string: firstFigure.thumbnail) {
              AsyncImage(url: thumbnailURL) { phase in
                switch phase {
                case .empty:
                  ProgressView()
                case .success(let image):
                  image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
                    .frame(width: 50, height: 50)
                    .border(Color.gray, width: 1)
                case .failure:
                  Image(systemName: "photo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.gray)
                    .frame(width: 50, height: 50)
                    .border(Color.gray, width: 1)
                @unknown default:
                  EmptyView()
                }
              }
            }
            else {
              placeholderImage
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(10)
                .frame(width: 40, height: 40) // Set the size for all thumbnails
                .border(Color.gray, width: 1) // Add border around thumbnails
            }
            
            VStack(alignment: .leading, spacing: 4) {
              Text(result.title)
                .font(.headline)
                .foregroundColor(.blue)
                .lineLimit(2) // Adjust as needed
              
              HStack {
                Text(result.publicationNumber)
                  .font(.caption)
                  .foregroundColor(.gray)
                
                Spacer()
                
                if let filingDate = result.filingDate {
                  Text(filingDate)
                    .font(.caption)
                    .foregroundColor(.gray)
                } else {
                  Text("N/A")
                    .font(.caption)
                    .foregroundColor(.gray)
                }
              }
            }
          }
        }
        
      }
      
      //This remains the same
      .sheet(item: $selectedresult) { result in
        ImageView(result: result, onClose: {
          selectedresult = nil
        })
      }
      .preferredColorScheme(.light)
        .navigationTitle("Search Results")

    }
}
