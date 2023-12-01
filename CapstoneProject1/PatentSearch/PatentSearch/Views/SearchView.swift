//
//  SearchView.swift
//  PatentSearch
//
//  Created by Srinivas Pala on 11/23/23.
//

import Foundation
import SwiftUI

struct SearchView: View {
  
  @ObservedObject private var patentStore = PatentStore.shared
  @State private var searchText = ""
  @State private var results: [OrganicResult] = []
  @State private var selectedresult: OrganicResult? = nil
  @State private var isImageDetailViewPresented = false
  let placeholderImage = Image(systemName: "photo")
  //var placeholder: String
  
  
  var body: some View {
    
    //    TextField(placeholder, text: $searchText, onCommit: {
    //                    // Add your onCommit logic here
    //                    print("Search for patents: \(searchText)")
    //                    // Call your search function
    //                    searchPatents(query: searchText)
    //                })
    
    SearchBar(text: $searchText, placeholder: "Search for patents") {
      // Add your logic here to handle onCommit action
      searchPatents(query: searchText)
    }
    
    
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
      
      
      
      //}
      //.padding(10)
      .onTapGesture {
        searchPatents(query: searchText)
        selectedresult = result
        isImageDetailViewPresented.toggle()
        
      }
      .onAppear {
        searchPatents(query: searchText)
      }
    }
    
    //This remains the same
    .sheet(item: $selectedresult) { result in
      ImageView(result: result, onClose: {
        selectedresult = nil
      })
    }
    .preferredColorScheme(.light)
  }
  
  struct SearchBar: View {
    @Binding var text: String
    var placeholder: String
    var onCommit: () -> Void
    
    var body: some View {
      HStack {
        TextField(placeholder, text: $text, onCommit: {
          onCommit() // Call the onCommit callback
        })
        .padding(8)
        .background(Color(.systemGray5))
        .cornerRadius(8)
        .padding([.leading, .trailing], 8)
      }
      .padding()
    }
  }
  
  private func searchPatents(query: String) {
    PatentStore.shared.fetchPatents(query: query) { result in
      switch result {
      case .success(let response):
        DispatchQueue.main.async {
          self.results = response.organicResults
          print("success")
        }
      case .failure(let error):
        print("Error fetching patents: \(error)")
      }
    }
  }
  
}
