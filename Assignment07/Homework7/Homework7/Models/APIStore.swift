
import Combine
import Foundation
import SwiftUI

class APIStore: ObservableObject {
  
  static let shared = APIStore()
  @Published var apiTasks: [APIModelEntry] = []
  @Published var showAlert: Bool = false
  @Published var loading: Bool = true
  @Published var downloadProgress: Float = 0.0
  
  let customTaskDelegate: CustomDataDelegate = CustomDataDelegate()
  
  var downloadProgressHandler: ((Float) -> Void)? {
    didSet {
      customTaskDelegate.downloadProgressHandler = downloadProgressHandler
    }
  }
  
  private let apiUrl = "https://api.publicapis.org/entries"
  
  init() {
    fetchData()
  }
  
  private func fetchData() {
    Task {
      do {
        
        let url = URL(string: apiUrl)!
        let request = URLRequest(url: url)
        let session = URLSession(configuration: .default, delegate: customTaskDelegate, delegateQueue: OperationQueue.main)
        let dataTask = session.dataTask(with: request) { [weak self] data, response, error in
          
          guard let self = self else { return }
          if let error = error {
            loadJSONData()
            loading = false
            return
          }
          
          if let httpResponse = response as? HTTPURLResponse {
            print("Response Status Code: \(httpResponse.statusCode)")
          }
          
          if let data = data {
            decodeAPITasks(data: data)
            loading = false
          }
        }
        customTaskDelegate.downloadProgressHandler = { progress in
          self.downloadProgress = progress
          print("Download Progress: \(progress)")
        }
        dataTask.resume()
        
      }
    }
  }
  
  private func loadJSONData() {
    
    if let apiJSONURL = Bundle.main.url(forResource: "apilist", withExtension: "json"),
       let data = try? Data(contentsOf: apiJSONURL) {
      decodeAPITasks(data: data)
    }
    else {
      self.showAlert = true
    }
  }
  
  
  private func decodeAPITasks(data: Data) {
    
    let decoder = JSONDecoder()
    
    do {
      let apidecodeddata = try decoder.decode(APIModel.self, from: data)
      apiTasks = apidecodeddata.entries
    } catch let error {
      print(error)
    }
  }
  
  func getAPITasks() -> [APIModelEntry] {
    
    return apiTasks
  }
  
  private func saveJSONAPITask() {
    let encoder = JSONEncoder()
    
    do {
      let apitaskData = try encoder.encode(apiTasks)
      let apitaskJSONURL = URL(fileURLWithPath: "apiTasks",
                               relativeTo: FileManager.documentsDirectoryURL).appendingPathExtension("json")
      
      try apitaskData.write(to: apitaskJSONURL, options: .atomicWrite)
      print("JSON data saved to: \(apitaskJSONURL)")
    } catch let error {
      print(error)
    }
  }
  
  //Not needed. I was trying all the options to get the ContentLength
  func calculateDownloadProgress(response: URLResponse?, receivedData: Data) -> Float {
    guard let expectedContentLength = response?.expectedContentLength, expectedContentLength > 0 else {
      return 0
    }
    
    let receivedContentLength = Int64(receivedData.count)
    print("RecievedData: \(receivedContentLength)")
    let progress = Float(receivedContentLength) / Float(expectedContentLength)
    print("progress in calculate: \(progress)")
    return progress
  }
  
  
}


