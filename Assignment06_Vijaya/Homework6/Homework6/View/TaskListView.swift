//
//  TaskListView.swift
//

import SwiftUI

struct TaskListView: View {
  @ObservedObject var taskStore: TaskStore
  
  @State private var selectedTab: Int = 0
  @State private var searchTxt = ""
  
  var categoryColumns: [GridItem] {
    [GridItem(.adaptive(minimum: 150, maximum: 170))]
  }
  
  var filteredTasks: [Task] {
    if searchTxt.isEmpty {
      return taskStore.tasks
    } else {
      return taskStore.tasks.filter { task in
        return task.title.localizedCaseInsensitiveContains(searchTxt)
      }
    }
  }
  
  func taskCount(for category: Category) -> Int {
    return taskStore.tasks.filter { $0.category == category }.count
  }
  
  var body: some View {
    VStack {
      ScrollViewReader { scrollProxy in
        TabView(selection: $selectedTab) {
          List(filteredTasks.filter { !$0.isCompleted }) { task in
            NavigationLink(value: task) {
              TaskRowView(task: $taskStore.tasks.first(where: { $0.id == task.id})!)
            }
          }
          .tabItem {
            Image(systemName: "list.bullet.circle")
              .resizable()
            Text("Tasks") }
          .tag(0)
          
          List(filteredTasks.filter { $0.isCompleted }) { task in
            NavigationLink(value: task) {
              TaskRowView(task: $taskStore.tasks.first(where: { $0.id == task.id})!)
            }
          }
          .tabItem {
            Image(systemName: "checkmark.circle")
              .resizable()
            Text("Completed") }
          .tag(1)
          
          GridView(taskStore: TaskStore())
            .tabItem {
              Image(systemName: "square.grid.2x2")
                .resizable()
              Text("Category") }
            .tag(2)
          
        }
        .navigationBarItems(trailing: selectedTab == 0 ? NavigationLink(destination: AddTaskView(taskStore: taskStore)) {
            Image(systemName: "plus.circle")
              .font(.title3)
              .bold()
        } : nil )
        .navigationDestination(
          for: Task.self,
          destination: { task in
            TaskDetailView(task: $taskStore.tasks.first(where: { $0.id == task.id})!)
          })
      }
      .searchable(text: $searchTxt )
    }
  }
}
