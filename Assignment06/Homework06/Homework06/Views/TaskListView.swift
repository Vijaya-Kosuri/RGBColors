

import Foundation

import SwiftUI

struct TaskListView: View {
  @ObservedObject var taskstore: TaskStore
  
  @State private var selectedTab: Int = 0
  @State private var searchTxt = ""
  
  var filteredTasks: [Task] {
          if searchTxt.isEmpty {
              return taskstore.tasks
          } else {
              return taskstore.tasks.filter { task in
                  return task.title.localizedCaseInsensitiveContains(searchTxt)
              }
          }
      }
  
  var body: some View {
    VStack {
      //      ScrollView {
      //        ForEach(taskstore.tasks, id: \.self) { task in
      //          NavigationLink(value: task) {
      //            VStack {
      //              TaskRowView(task: task)
      //            }
      //            .padding([.leading,.trailing],20)
      //          }
      //        }
      //        .navigationDestination(for: Task.self) { task in
      //          TaskDetailView(task: $taskstore.tasks.first(where: { $0.id == task.id})!)
      //        }
      //      }
      
      ScrollViewReader { scrollProxy in
        TabView(selection: $selectedTab) {
          List(filteredTasks.filter { !$0.isCompleted }) { task in
            NavigationLink(value: task) {
              TaskRowView(task: $taskstore.tasks.first(where: { $0.id == task.id})!)
            }
          }
          .tabItem {
            Image(systemName: "list.bullet.circle")
              .resizable()
            Text("Tasks") }
          .tag(0)
        
          //          .navigationBarItems(trailing:
          //                      selectedTab == 0 ?
          //                      NavigationLink(destination: NewTaskView(viewModel: viewModel)) {
          //                          Text("Add New Task")
          //                      } : nil
          //        .navigationDestination(
          //          for: Task.self,
          //          destination: { task in
          //            TaskDetailView(task: $taskstore.tasks.first(where: { $0.id == task.id})!)
          //          }
          //        )
          
          List(filteredTasks.filter { $0.isCompleted }) { task in
            NavigationLink(value: task) {
              TaskRowView(task: $taskstore.tasks.first(where: { $0.id == task.id})!)
            }
          }
          .tabItem {
            Image(systemName: "checkmark.circle")
              .resizable()
            Text("Completed") }
          .tag(1)
          
        }
        
        .navigationBarItems(trailing: selectedTab == 0 ? NavigationLink(destination: AddTaskView(taskstore: taskstore)) {
//        label: {
//                      Image(systemName: "plus.square.fill")
//                      Text("New Task")
//                    }
          
        Text("New Task").bold()
        } : nil )
        .navigationDestination(
          for: Task.self,
          destination: { task in
            TaskDetailView(task: $taskstore.tasks.first(where: { $0.id == task.id})!)
          }
        )
      }
      
      //        .onAppear {
      //          scrollProxy.scrollTo(nextFlightId, anchor: .center)
      //        }
      //      }
      
    }
    .searchable(text: $searchTxt )
  }
}




