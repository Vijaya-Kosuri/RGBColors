

import SwiftUI

// This is the main view which calls the TaskDetailView and AddTaskView

struct ContentView: View {
  
  @ObservedObject var viewModel: Store
  @State private var newTaskTitle: String = ""
  @State private var newTaskNotes: String = ""
  @State private var isAddingTask: Bool = false
  @State private var isDetailSheetPresented = false
  
  
  var body: some View {
    
    ScrollView {
      VStack {
        Spacer()
        Text("My Tasks")
          .font(.largeTitle)
          .bold()
          .padding(.leading)
          .frame(maxWidth: .infinity, alignment: .leading)
        Spacer()
        
        ForEach(0..<viewModel.tasks.count, id: \.self) { index in
          TaskRowViewSet(task: viewModel, taskIndex: index)
          
        }
      }
      .onAppear {
        UITableView.appearance().separatorStyle = .singleLine
      }
    }
    HStack {
      Spacer()
      Button(action: {
        isAddingTask.toggle()
      }) {
        HStack {
          Image(systemName: "plus.square.fill")
          Text("New Task")
        }
        .font(.headline)
        .padding()
        .foregroundColor(.blue)
        .frame(maxWidth: .infinity, alignment: .bottomLeading)
      }
      .sheet(isPresented: $isAddingTask) {
        AddTaskView(isPresented: $isAddingTask, taskTitle: $newTaskTitle, taskNotes: $newTaskNotes, viewModel: viewModel)
      }
      .padding()
    }
    Spacer()
    
  }
  
}

struct TaskRowViewSet: View {
  @ObservedObject var task: Store
  var taskIndex: Int = 0
  @State private var isDetailSheetPresented = false
  @State private var selectedTask: Task = Task(title: "Sample Task", notes: "Sample", isCompleted: false)
  
  var body: some View {
    
    HStack {
      Button(action: {
        isDetailSheetPresented.toggle()
      }) {
        Text(task.tasks[taskIndex].title)
        
          .sheet(isPresented: $isDetailSheetPresented) {
            TaskDetailView(task: task.tasks[taskIndex], isPresented: $isDetailSheetPresented, isCompleted: $selectedTask.isCompleted )
          }
        
      } .padding()
      Button(action: {
        task.completeTask(task: task.tasks[taskIndex])
      }) {
        HStack {
          Spacer()
          if task.tasks[taskIndex].isCompleted {
            Image(systemName: "checkmark.square.fill")
              .foregroundColor(.green)
          } else {
            Image(systemName: "square")
              .foregroundColor(.red)
          }
        }
        .padding()
      }
    }
  }
}

#Preview {
  ContentView(viewModel: Store())
}
