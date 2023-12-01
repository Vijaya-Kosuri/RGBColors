import Foundation

struct PatentFeedback: Identifiable {
  let id = UUID()
  let patentID: String
  let rating: Int
  let review: String
}
