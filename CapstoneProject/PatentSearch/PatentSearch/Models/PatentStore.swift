//
//  PatentStore.swift
//  PatentSearch
//

import Foundation

@MainActor
class PatentStore: ObservableObject {
  static let shared = PatentStore()
  private let apiUrl = "https://serpapi.com/search.json"
  @Published var showAlert: Bool = false
  @Published var apiTasks: [OrganicResult] = []
  @Published var advapiTasks: [OrganicResult] = []
  @Published var feedbacks: [PatentFeedback] = []
  
  private var apiKey: String {
    guard let url = Bundle.main.url(forResource: "patent_info", withExtension: "plist"),
          let data = try? Data(contentsOf: url),
          let plist = try? PropertyListSerialization.propertyList(from: data, options: [], format: nil) as? [String: Any],
          let apiKey = plist["API_KEY"] as? String else {
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
        return
      }
      print("url:\(apiUrlWithQuery)")
      let request = URLRequest(url: apiUrlWithQuery)
      
      URLSession.shared.dataTask(with: request) { data, response, error in
        if let error = error {
          completion(.failure(error))
          return
        }
        if let data = data {
          do {
            print("Received data: \(String(data: data, encoding: .utf8) ?? "")")
            let decoder = JSONDecoder()
            let response = try decoder.decode(PatentModel.self, from: data)
            completion(.success(response))
          } catch let decodingError{
            print("Decoding error: \(decodingError)")
            completion(.failure(decodingError))
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
        URLQueryItem(name: "api_key",value: apiKey)
      ]
      
      guard let apiUrlWithQuery = urlComponents.url else {
        completion(.failure(NSError(domain: "Invalid API URL with Query", code: 400, userInfo: nil)))
        return
      }
      print("url:\(apiUrlWithQuery)")
      let request = URLRequest(url: apiUrlWithQuery)
      //      request.addValue("\(apiKey)", forHTTPHeaderField: "Authorization")
      
      URLSession.shared.dataTask(with: request) { data, response, error in
        if let error = error {
          completion(.failure(error))
          return
        }
        if let data = data {
          do {
            print("Received data: \(String(data: data, encoding: .utf8) ?? "")")
            let decoder = JSONDecoder()
            let response = try decoder.decode(PatentModel.self, from: data)
            completion(.success(response))
          } catch let decodingError{
            print("Decoding error: \(decodingError)")
            completion(.failure(decodingError))
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
  
  
}

