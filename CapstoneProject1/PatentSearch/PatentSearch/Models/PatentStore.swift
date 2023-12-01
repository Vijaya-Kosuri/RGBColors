//
//  PatentStore.swift
//  PatentSearch
//
//  Created by Srinivas Pala on 11/18/23.
//

import Foundation

@MainActor
class PatentStore: ObservableObject {
  static let shared = PatentStore()
  private let apiUrl = "https://serpapi.com/search.json"
  @Published var showAlert: Bool = false
  //@Published var searchmetdata : 
  @Published var apiTasks: [OrganicResult] = []
  @Published var advapiTasks: [OrganicResult] = []
  @Published var feedbacks: [PatentFeedback] = []
  
  private var apiKey: String {
          guard let url = Bundle.main.url(forResource: "ApiKeys", withExtension: "plist"),
                let data = try? Data(contentsOf: url),
                let plist = try? PropertyListSerialization.propertyList(from: data, options: [], format: nil) as? [String: Any],
                let apiKey = plist["ApiKey"] as? String else {
              fatalError("API key not found in the property list.")
          }
          return apiKey
      }
  
  init() {
    loadJSONData()
  }
  
  func fetchPatents(query: String, completion: @escaping (Result<PatentModel, Error>) -> Void) {
    Task {
      guard var urlComponents = URLComponents(string: apiUrl) else {
        completion(.failure(NSError(domain: "Invalid API URL", code: 400, userInfo: nil)))
        return
      }
      urlComponents.queryItems = [
        URLQueryItem(name: "engine", value: "google_patents"),
        URLQueryItem(name: "q", value: query),
        URLQueryItem(name: "api_key",value: apiKey)
      ]
      
      guard let apiUrlWithQuery = urlComponents.url else {
        completion(.failure(NSError(domain: "Invalid API URL with Query", code: 400, userInfo: nil)))
        print("Error 1")
        return
      }
      print("url:\(apiUrlWithQuery)")
      let request = URLRequest(url: apiUrlWithQuery)
//      request.addValue("\(apiKey)", forHTTPHeaderField: "Authorization")
      print("Error 2")
      
      URLSession.shared.dataTask(with: request) { data, response, error in
        if let error = error {
          print("error 3")
          completion(.failure(error))
          return
        }
        if let data = data {
          do {
            print("error 4")
            print("Received data: \(String(data: data, encoding: .utf8) ?? "")")
            let decoder = JSONDecoder()
            print("err")
            let response = try decoder.decode(PatentModel.self, from: data)
            print("err 7")
            completion(.success(response))
            print("error 5")
          } catch let decodingError{
            print("Decoding error: \(decodingError)")
            completion(.failure(decodingError))
            print("error 6")
          }
        } else {
          completion(.failure(NSError(domain: "No data received", code: 400, userInfo: nil)))
        }
      }.resume()
    }
  }
  
  func advfetchPatents(query: String, inventor: String, assignee: String, before: String, after: String, completion: @escaping (Result<PatentModel, Error>) -> Void) {
    Task {
      guard var urlComponents = URLComponents(string: apiUrl) else {
        completion(.failure(NSError(domain: "Invalid API URL", code: 400, userInfo: nil)))
        return
      }
      urlComponents.queryItems = [
        URLQueryItem(name: "engine", value: "google_patents"),
        URLQueryItem(name: "q", value: "Messaging"),
        URLQueryItem(name: "inventor", value: inventor),
        URLQueryItem(name: "assignee", value: assignee),
        URLQueryItem(name: "before", value: before),
        URLQueryItem(name: "after", value: after),
        URLQueryItem(name: "api_key",value: "72285caf5a386084b97e755c5404351e1877753fd8a07986ef8284329d55d7cc")
      ]
      
      guard let apiUrlWithQuery = urlComponents.url else {
        completion(.failure(NSError(domain: "Invalid API URL with Query", code: 400, userInfo: nil)))
        print("Error 1")
        return
      }
      print("url:\(apiUrlWithQuery)")
      let request = URLRequest(url: apiUrlWithQuery)
//      request.addValue("\(apiKey)", forHTTPHeaderField: "Authorization")
      print("Error 2")
      
      URLSession.shared.dataTask(with: request) { data, response, error in
        if let error = error {
          print("error 3")
          completion(.failure(error))
          return
        }
        if let data = data {
          do {
            print("error 4")
            print("Received data: \(String(data: data, encoding: .utf8) ?? "")")
            let decoder = JSONDecoder()
            print("err")
            let response = try decoder.decode(PatentModel.self, from: data)
            print("err 7")
            completion(.success(response))
            print("error 5")
          } catch let decodingError{
            print("Decoding error: \(decodingError)")
            completion(.failure(decodingError))
            print("error 6")
          }
        } else {
          completion(.failure(NSError(domain: "No data received", code: 400, userInfo: nil)))
        }
      }.resume()
    }
  }
  
  func submitFeedback(patentID: String, rating: Int, review: String) {
          let feedback = PatentFeedback(patentID: patentID, rating: rating, review: review)
          feedbacks.append(feedback)
      }
  
   private func loadJSONData() {
    
//    if let apiJSONURL = Bundle.main.url(forResource: "apilist", withExtension: "json"),
//       let data = try? Data(contentsOf: apiJSONURL) {
//      decodeAPITasks(data: data)
//    }
//    else {
//      self.showAlert = true
//    }
     do {
       if let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
         let fileURL = documentsDirectory.appendingPathComponent("savedResults.json")
         
         let data = try Data(contentsOf: fileURL)
         let decoder = JSONDecoder()
         apiTasks = try decoder.decode([OrganicResult].self, from: data)
         
         print("Results loaded locally: \(apiTasks)")
       }
     }
     catch {
             print("Error loading results locally: \(error)")
         }
     
  }
  
  
  private func decodeAPITasks(data: Data) {
    
    let decoder = JSONDecoder()
    
    do {
      let apidecodeddata = try decoder.decode(PatentModel.self, from: data)
      apiTasks = apidecodeddata.organicResults
    } catch let error {
      print(error)
    }
  }
  
  func getAPITasks() -> [OrganicResult] {
    
    return apiTasks
  }
  
//  private func saveJSONData() {
//      let encoder = JSONEncoder()
//      
//      do {
//        let userData = try encoder.encode(apiTasks)
//        let userJSONURL = URL(fileURLWithPath: "Users",
//                              relativeTo: FileManager.documentsDirectoryURL).appendingPathExtension("json")
//        
//        try userData.write(to: userJSONURL, options: .atomicWrite)
//        print("JSON data saved to: \(userJSONURL)")
//      } catch let error {
//        print(error)
//      }
//    }
}
  
