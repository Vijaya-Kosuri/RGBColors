//
//  SearchView.swift
//  PatentSearch
//
//

import Foundation
import SwiftUI

struct SearchView: View {
  
  @ObservedObject private var patentStore = PatentStore.shared
  @State private var searchText = ""
  @State var results: [OrganicResult] = []
  @State private var selectedresult: OrganicResult? = nil
  @State private var isImageDetailViewPresented = false
  let placeholderImage = Image(systemName: "photo")
  
  
  var body: some View {
    
    SearchBar(text: $searchText, placeholder: "Search for patents") {
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
        searchPatents(query: searchText)
        selectedresult = result
        isImageDetailViewPresented.toggle()
        
      }
      .onAppear {
        searchPatents(query: searchText)
      }
    }
    .sheet(item: $selectedresult) { result in
      DetailedView(result: result, onClose: {
        selectedresult = nil
      })
    }
  }
  
  struct SearchBar: View {
    @Binding var text: String
    var placeholder: String
    var onCommit: () -> Void
    
    var body: some View {
      HStack {
        TextField(placeholder, text: $text, onCommit: {
          onCommit()
        })
        .padding(8)
        .background(Color(.systemGray5))
        .cornerRadius(8)
        .padding([.leading, .trailing], 8)
      }
      .padding()
    }
  }
  
  func searchPatents(query: String) {
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
