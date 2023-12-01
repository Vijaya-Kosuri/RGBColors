//
//  SearchView.swift
//  PatentSearch
//
//

import Foundation
import SwiftUI

struct SavedView: View {
  
  @ObservedObject private var patentStore = PatentStore.shared
  @State private var searchText = ""
  @ObservedObject var resultsViewModel = ResultsViewModel()
  @State private var selectedresult: OrganicResult? = nil
  @State private var isDetailedViewPresented = false
  
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
              .frame(width: 40, height: 40)
              .border(Color(UIColor.systemGray), width: 1)
          }
          
          VStack(alignment: .leading, spacing: 4) {
            Text(result.title)
              .font(.headline)
              .foregroundColor(.blue)
              .lineLimit(2) 
            
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
        isDetailedViewPresented.toggle()
      }
      
      .onAppear {
        resultsViewModel.loadResultsLocally()
      }
      
      .sheet(isPresented: $isDetailedViewPresented) {
        DetailedView(result: result, onClose: {
          selectedresult = nil
        }, isPresented: $isDetailedViewPresented)
        }
      
    }
//    .sheet(item: $selectedresult) { result in
//      DetailedView(result: result, onClose: {
//        selectedresult = nil
//      })
   // }
//    .sheet(isPresented: $isDetailedViewPresented) {
//      if let selectedresult = selectedresult {
//        DetailedView(result: selectedresult, onClose: {
//        }, isPresented: $isDetailedViewPresented)
//      }
//    }
  }
  
}

