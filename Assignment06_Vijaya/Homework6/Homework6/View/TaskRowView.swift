//
//  TaskRow.swift
//  

import SwiftUI

struct TaskRowView: View {
  @Binding var task: Task
  @State private var isChecked: Bool = false
  
  var body: some View {
    
    Button(action: {
      withAnimation(Animation.easeInOut(duration: 0.3)) {
        isChecked.toggle()
        task.isCompleted.toggle()
      }
    })
    {
      HStack {
        Text(task.title)
        Spacer()
        Image(systemName: task.isCompleted ? "checkmark.square" : "square")
          .foregroundColor(task.isCompleted ? Color.green : Color.red)
      }
      .font(.title3)
      .bold()
      .padding([.top, .bottom], 15)
      .padding([.leading, .trailing], 10)
    }
  }
}

