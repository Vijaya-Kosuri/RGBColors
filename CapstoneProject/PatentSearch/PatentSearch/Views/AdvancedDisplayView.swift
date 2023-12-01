

import Foundation
import SwiftUI

struct AdvancedDisplayView: View {
  var results: [OrganicResult]
  @State private var searchText = ""
  @State var selectedresult: OrganicResult? = nil
  @State private var isImageDetailViewPresented = false
  let placeholderImage = Image(systemName: "photo")
  
  
  var body: some View {
    if results.isEmpty {
      Text("No results available")
        .foregroundColor(.gray)
        .padding()
    } else {
      List(results, id: \.id) { result in
        VStack(alignment: .leading, spacing: 8) {
          HStack(alignment: .top, spacing: 8) {
            
            if let firstFigure = result.figures?.first,
               let thumbnailURL = URL(string: firstFigure.thumbnail) {
              AsyncImage(url: thumbnailURL) { phase in
                switch phase {
                case .empty:
                  Text("Image Not Available")
                    .foregroundColor(.gray)
                    .frame(width: 50, height: 50)
                    .border(Color.gray, width: 1)
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
                .frame(width: 40, height: 40)
                .border(Color.gray, width: 1)
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
        
        .onTapGesture {
          selectedresult = result
          isImageDetailViewPresented.toggle()
          
        }
        .accessibility(identifier: "tapview")
        
        .sheet(item: $selectedresult) { result in
          DetailedView(result: result, onClose: {
            selectedresult = nil
          })
        }
      }
      .navigationTitle("Search Results")
      
    }
  }
}
