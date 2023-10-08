
import Foundation
import SwiftUI

struct Task: Identifiable, Hashable {
  let id = UUID()
  var title: String
  var category: Category
  var isCompleted: Bool = false
  var notes: String = ""
}


enum Category: String, CaseIterable {
  case personal = "Personal"
  case work = "Work"
  case home = "Home"
  case noCategory = "No Category"
}

class TaskStore: ObservableObject {
  @Published var tasks: [Task] = []
  @Published var addingTask = false
  
  init(_loadData: Bool = true) {
    tasks.append(Task(title: "Buy Groceries", category: .home, isCompleted: true))
    tasks.append(Task(title: "Go to Kohls", category: .home, isCompleted: false))
    tasks.append(Task(title: "Meetings", category: .work, isCompleted: true))
    tasks.append(Task(title: "Update the forms", category: .personal, isCompleted: false))
    
  }
  
  func addTask(title:String){
    
    tasks.append(Task(title: title, category: .noCategory))
  }
  
  func toggleTaskCompletion(task : Task) {
    if let index = tasks.firstIndex(where: { $0.id == task.id}) {
      tasks[index].isCompleted.toggle()
    }
  }
}
