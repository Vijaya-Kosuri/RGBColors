import Combine
import Foundation

class UserStore: ObservableObject {
  
  @Published var users: [UserModelEntry] = []
  
  init() {
    loadJSONData()
    saveJSONData()
  }
  
  func loadJSONData() {
    
    if let path = Bundle.main.path(forResource: "Userdata", ofType: "json") {
      do {
        let data = try Data(contentsOf: URL(fileURLWithPath: path))
        let decodedUsers = try JSONDecoder().decode(UserModel.self , from: data)
        users = decodedUsers.results
      } catch {
        print("Error decoding user data: \(error)")
      }
    } else {
      print("Userdata.json file not found in the app bundle.")
    }
  }
  
  func getUsers() -> [UserModelEntry] {
    return users
  }
  
  private func saveJSONData() {
    let encoder = JSONEncoder()
    
    do {
      let userData = try encoder.encode(users)
      let userJSONURL = URL(fileURLWithPath: "Users",
                            relativeTo: FileManager.documentsDirectoryURL).appendingPathExtension("json")
      
      try userData.write(to: userJSONURL, options: .atomicWrite)
      print("JSON data saved to: \(userJSONURL)")
    } catch let error {
      print(error)
    }
  }
  
}
