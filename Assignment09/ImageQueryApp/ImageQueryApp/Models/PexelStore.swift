
import Foundation
import SwiftUI

class PexelStore: ObservableObject {
  static let shared = PexelStore()
  private let apiUrl = "https://api.pexels.com/v1/search"
  private let apiKey = "rymMcTZ84u5B5D7s2qqE6OSj79C9KuS83qSyNrFCmE93EpAbEMEB1e4e"
  @Published var photos: [PexelsPhoto] = []
  
  
  func fetchPhotos(query: String, page: Int, perPage: Int, completion: @escaping (Result<PexelsResponse, Error>) -> Void) {
    Task {
      guard var urlComponents = URLComponents(string: apiUrl) else {
        completion(.failure(NSError(domain: "Invalid API URL", code: 400, userInfo: nil)))
        return
      }
      urlComponents.queryItems = [
        URLQueryItem(name: "query", value: query),
      ]
      
      guard let apiUrlWithQuery = urlComponents.url else {
        completion(.failure(NSError(domain: "Invalid API URL with Query", code: 400, userInfo: nil)))
        return
      }
      var request = URLRequest(url: apiUrlWithQuery)
      request.addValue("\(apiKey)", forHTTPHeaderField: "Authorization")
      
      URLSession.shared.dataTask(with: request) { data, response, error in
        if let error = error {
          completion(.failure(error))
          return
        }
        if let data = data {
          do {
            let decoder = JSONDecoder()
            let response = try decoder.decode(PexelsResponse.self, from: data)
            completion(.success(response))
          } catch {
            completion(.failure(error))
          }
        } else {
          completion(.failure(NSError(domain: "No data received", code: 400, userInfo: nil)))
        }
      }.resume()
    }
  }
}
