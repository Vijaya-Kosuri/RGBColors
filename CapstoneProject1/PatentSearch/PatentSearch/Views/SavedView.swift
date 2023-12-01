//
//  SearchView.swift
//  PatentSearch
//
//  Created by Srinivas Pala on 11/23/23.
//

import Foundation
import SwiftUI

struct SavedView: View {
  
  @ObservedObject private var patentStore = PatentStore.shared
  @State private var searchText = ""
  @ObservedObject var resultsViewModel = ResultsViewModel()
  @State private var selectedresult: OrganicResult? = nil
  @State private var isImageDetailViewPresented = false
  let placeholderImage = Image(systemName: "photo")
  
  
  var body: some View {
    
    List(resultsViewModel.results, id: \.id) { result in
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
              .border(Color(UIColor.systemGray), width: 1)// Add border around thumbnails
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
        
        
        
      //}
      //.padding(10)
      .onTapGesture {
        selectedresult = result
        isImageDetailViewPresented.toggle()
      }
      
      .onAppear {
        resultsViewModel.loadResultsLocally()
      }
      
    }
    
    //This remains the same
    .preferredColorScheme(.light)
    .sheet(item: $selectedresult) { result in
      ImageView(result: result, onClose: {
        selectedresult = nil
      })
    }
  }
  
}

