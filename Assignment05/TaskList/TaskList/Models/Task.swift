
import Foundation

struct Task : Identifiable {
  var id = UUID()
  var title : String
  var notes : String
  var isCompleted : Bool = false
}
