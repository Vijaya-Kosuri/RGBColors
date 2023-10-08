

import Foundation

import SwiftUI

struct TaskRowView: View {
  @Binding var task : Task
  @State private var isChecked: Bool = false
  
  var body: some View {
    
    Button(action: {
      withAnimation(Animation.easeInOut(duration: 0.3)) {
        isChecked.toggle()
        task.isCompleted.toggle()
      }
    })
    {
      //      HStack {
      //        Text(task.title)
      //        Spacer()
      //        Image(systemName: task.isCompleted ? "checkmark.square" : "square")
      //          .foregroundColor(task.isCompleted ? Color.green : Color.red)
      //      }
      //      .font(.title)
      //      .bold()
      //      .padding([.top,.bottom], 15)
      //      .padding([.leading, .trailing], 10)
      HStack {
        Text(task.title)
        Spacer()
        Image(systemName: task.isCompleted ? "checkmark.square.fill" : "square")
          .imageScale(.large)
          //.rotationEffect(Angle(degrees: isChecked ? 45 : 0))
          .foregroundColor(task.isCompleted ? .green : .red)
      }
      
    }
    .onAppear {
      isChecked = task.isCompleted
    }
  }
}

//struct TaskRow_Previews: PreviewProvider {
//  static var previews: some View {
//    TaskRowView(task: Task(title: "My task", category: .noCategory, isCompleted: false))
//  }
//}
