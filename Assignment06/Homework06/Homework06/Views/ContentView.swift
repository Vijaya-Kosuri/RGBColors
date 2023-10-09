

import SwiftUI

struct ContentView: View {
  @StateObject var taskStore = TaskStore()
  @State private var isAddingTask: Bool = false
  @State private var searchTxt = ""
  //@AppStorage("TaskStatusCurrentTab") var selectedTab = 1
  
  var body: some View {
    NavigationStack {
      VStack {
        if taskStore.tasks.isEmpty {
          Text("No tasks Found")
        }
        else {
          TaskListView(taskstore: taskStore)
        }
        Spacer()
        
        //.padding([.trailing], 180)
      }
      //.navigationTitle("My Tasks")
      .toolbar {
//        ToolbarItem(placement: .topBarTrailing) {
//          HStack {
//            Button {
//              isAddingTask.toggle()
//            } label: {
//              Image(systemName: "plus.square.fill")
//              Text("New Task")
//            }
//            Spacer()
//          }
//          .bold()
//        }
        ToolbarItem(placement: .topBarLeading) {
          Text("My Tasks")
            .font(.title)
            .bold()
        }
        
      }
      .sheet(isPresented: $isAddingTask) {
        AddTaskView(taskstore: taskStore)
     }
    }
  }
}
#Preview {
    ContentView()
}
