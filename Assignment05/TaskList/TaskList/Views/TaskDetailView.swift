

import Foundation
import SwiftUI

// This view is to get the detailed view of the tasks
// Challenges faced : To remove the extra space between the navigation bar and the text fields.

struct TaskDetailView: View {
  var task: Task
  @Binding var isPresented: Bool
  @Binding var isCompleted: Bool
  
  var body: some View {
    NavigationView {
      VStack(spacing: 0) {
        Text("TASK TITLE")
          .padding()
          .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
          .foregroundColor(.gray)
        Text(task.title)
          .padding(.top, -200)
          .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
          .padding()
          .foregroundColor(.black)
        
        Text("NOTES")
          .padding(.top, -300)
          .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
          .foregroundColor(.gray)
          .padding()
        Text(task.notes)
          .padding(.top, -425)
          .foregroundColor(.black)
          .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
          .padding()
        
        Toggle("Completed", isOn: $isCompleted)
          .padding(.top,-450)
          .toggleStyle(SwitchToggleStyle(tint: .white))
          .padding()
      }
      .background(Color(red: 240/255, green: 240/255, blue: 240/255))
      .navigationBarTitle("", displayMode: .inline)
      .navigationBarItems(leading: Button(action: {
        isPresented = false
      }) {
        HStack {
          Image(systemName: "chevron.backward")
          Text("My Tasks")
        }
      })
      .navigationBarTitleDisplayMode(.inline) 
      .padding(0)
      
    }
  }
}
