
import Combine
import Foundation

class APIStore: ObservableObject {
  
  static let shared = APIStore()
  @Published var apiTasks: [APIModelEntry] = []
  
  let apiJSONURL =  URL(fileURLWithPath: "apiTask",relativeTo: FileManager.documentsDirectoryURL).appendingPathExtension("json")
  
  init() {
    loadJSONData()
    saveJSONAPITask()
  }
  
  private func loadJSONData() {
    
    if let apiJSONURL = Bundle.main.url(forResource: "apilist", withExtension: "json"),
       let data = try? Data(contentsOf: apiJSONURL) {
      decodeAPITasks(data: data)
    } else {
      if let apiJSONURL =  try? URL(fileURLWithPath: "apiTasks",relativeTo: FileManager.documentsDirectoryURL).appendingPathExtension("json"),
         let data = try? Data(contentsOf: apiJSONURL) {
        decodeAPITasks(data: data)
      }
      else {
        print("Error: API services data not found.")
      }
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
}


