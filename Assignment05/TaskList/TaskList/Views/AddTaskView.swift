
import Foundation
import SwiftUI

//This view is to add the tasks in the list
// Challenges faced: Tried to use Background rectangle overlaying a text field.
struct AddTaskView: View {
  @Binding var isPresented: Bool
  @Binding var taskTitle: String
  @Binding var taskNotes: String
  @ObservedObject var viewModel: Store
  @State private var isEditing: Bool = false
  @State private var isAddButtonEnabled: Bool = false
  
  var body: some View {
    NavigationView {
      VStack {
        Text("TASK TITLE")
          .padding()
          .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
          .foregroundColor(.gray)
        
        TextField("Enter task", text: $taskTitle,  onEditingChanged: { editing in
          isEditing = editing
        })
        .padding(.top, -125)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .padding()
        .foregroundColor(isEditing ? .black : .gray)
        
        Text("NOTES")
          .padding(.top, -300)
          .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
          .foregroundColor(.gray)
          .padding()
        
        ZStack(alignment: .topLeading) {
          Rectangle()
            .foregroundColor(Color.white)
            .padding(.top, -350)
            .frame(minHeight: 100) // Minimum height for five lines
            .border(Color.gray, width: 1)
          
          
          TextField("Notes", text: $taskNotes,  onEditingChanged: { editing in
            isEditing = editing
          })
          .padding(.top, -420)
          .navigationBarHidden(false)
          .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
          .padding()
          .foregroundColor(isEditing ? .black : .gray)
        }
      }
      .background(Color(red: 240/255, green: 240/255, blue: 240/255))
      
      .navigationBarItems(leading: Button("Cancel") {
        isPresented.toggle()
      })
      .navigationBarTitle("Adding New Task", displayMode: .inline)
      .navigationBarItems(trailing: Button("Add task") {
        viewModel.addTask(title: taskTitle, notes: taskNotes)
        isPresented.toggle()
      }
        .disabled(taskTitle.isEmpty || taskNotes.isEmpty)
      )
    }
  }
}
