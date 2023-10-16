
import Foundation

struct APIModel: Codable {
  let entries: [APIModelEntry]
}

struct APIModelEntry: Codable, Identifiable {
  let id = UUID()
  let API: String
  let Description: String
  let Auth: String
  let HTTPS: Bool
  let Cors: String
  let Link: String
  let Category: String
}
