

import Foundation
import SwiftUI

struct AddTaskView: View {
  @Environment(\.dismiss) var dismiss
  @ObservedObject var taskstore : TaskStore
  @State private var title = ""
  @State private var notes = ""
  @State private var category = ""
  
  var body: some View {
    NavigationStack {
      Form {
        Section(header: Text("Task Title")) {
          TextField("Title", text: $title )
        }
        Section(header: Text("Notes")) {
          TextField("Notes", text: $notes, axis: .vertical )
            .lineLimit(5...)
        }
      }
      .toolbar{
        ToolbarItem(placement: .navigationBarLeading) {
          Button(action: {
            taskstore.addingTask = false
            dismiss()
          }, label: {Text("Cancel")
          })
        }
        ToolbarItem(placement: .principal) {
          Text("Adding New Task")
            .font(.headline)
        }
        
        ToolbarItem(placement: .navigationBarTrailing) {
          Button(action: {
            taskstore.addTask(title: title)
            taskstore.addingTask = false
            dismiss()
          }, label: {Text("Add")
          })
          .disabled(title.isEmpty)
        }
        
      }
    }
  }
}
