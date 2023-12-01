//
//  ResultsViewModel.swift
//  PatentSearch
//

import Foundation

class ResultsViewModel: ObservableObject {
  @Published var results: [OrganicResult] = []
  
  init() {
    loadResultsLocally()
  }
  
  func saveResultsLocally(newResult: OrganicResult) {
    do {
      
      var existingResults = results
      let encoder = JSONEncoder()
      encoder.outputFormatting = .prettyPrinted
      //var existingResults: [OrganicResult] = loadResultsLocally()
      
      print("existingResults: \(existingResults)")
      
      print("new result \(newResult)")
      
      existingResults.append(newResult)
      var uniqueIds = Set(existingResults.map { $0.id })
      
      // Check for duplicates
      if uniqueIds.insert(newResult.id).inserted {
        // Append the new result only if it's not a duplicate
        existingResults.append(newResult)
      }
      
      var data: Data
      
      if existingResults.count == 1 {
        data = try encoder.encode(existingResults)
      }
      else {
        data = try encoder.encode(existingResults)
      }
      
      if let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
        let fileURL = documentsDirectory.appendingPathComponent("savedResults.json")
        try data.write(to: fileURL)
        print("File URL: \(fileURL.path)")
        
        DispatchQueue.main.async {
          self.results = existingResults
        }
      }
    } catch {
      print("Error saving results locally: \(error)")
    }
  }
  
  func loadResultsLocally() {
    do {
      if let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
        let fileURL = documentsDirectory.appendingPathComponent("savedResults.json")
        
        let data = try Data(contentsOf: fileURL)
        let decoder = JSONDecoder()
        let results = try decoder.decode([OrganicResult].self, from: data)
        
        DispatchQueue.main.async {
          self.results = results
        }
      }
    } catch {
      print("Error loading results locally: \(error)")
    }
    
  }
  
  
}
