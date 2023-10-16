

import Foundation

struct UserModel: Codable {
  let results: [UserModelEntry]
}

struct UserModelEntry: Codable, Identifiable {
  let id = UUID()
  
  struct Name: Codable {
    let title: String
    let first: String
    let last: String
  }
  
  struct Location: Codable {
    struct Street: Codable {
      let number: Int
      let name: String
    }
    
    let street: Street
    let city: String
    let state: String
    let country: String
    let postcode: Int
  }
  
  struct Coordinates: Codable {
    let latitude: String
    let longitude: String
  }
  
  struct Timezone: Codable {
    let offset: String
    let description: String
  }
  
  struct Login: Codable {
    let uuid: String
    let username: String
    let password: String
    let salt: String
    let md5: String
    let sha1: String
    let sha256: String
  }
  
  struct DOB: Codable {
    let date: String
    let age: Int
  }
  
  struct Registered: Codable {
    let date: String
    let age: Int
  }
  
  struct Picture: Codable {
    let large: String
    let medium: String
    let thumbnail: String
  }
  
  let gender: String
  let name: Name
  let location: Location
  let email: String
  let login: Login
  let dob: DOB
  let registered: Registered
  let phone: String
  let cell: String
  let picture: Picture
  let nat: String
  
  
}
