
import Foundation

class Store  : ObservableObject {
  @Published var tasks : [Task] = []
  
  init() {
    self.tasks = [
      Task(title: "Groceries", notes: "chapathi"),
      Task(title: "Library books return", notes: "Srinidhi and Bubby"),
      Task(title: "Attend conference", notes: ""),
      Task(title: "Complete HW", notes: ""),
      Task(title: "Go to Shopping", notes: ""),
      Task(title: "Kohls", notes: "Get tops"),
    ]
  }
  
  func addTask(title: String, notes: String) {
    let task = Task(title: title, notes: notes)
    tasks.append(task)
  }
  
  func completeTask(task : Task)
  {
    if let index = tasks.firstIndex(where: { $0.id == task.id }) {
      tasks[index].isCompleted.toggle()
    }
  }
}
