//
//  Grid.swift
//

import SwiftUI

struct GridView: View {
  @ObservedObject var taskStore: TaskStore
  
  var categoryColumns: [GridItem] {
    [GridItem(.adaptive(minimum: 150, maximum: 170))]
  }
  
  @State private var selectedCategory: Category?
  
  var filteredCategories: [Task] {
       if let selectedCategory = selectedCategory {
         return taskStore.tasks.filter { $0.category == selectedCategory }
       } else {
         return taskStore.tasks
       }
   }
  
  func taskCount(for category: Category) -> Int {
    return taskStore.tasks.filter { $0.category == category }.count
  }
  
  var body: some View {
    VStack {
      
      LazyVGrid(columns: categoryColumns, spacing: 5) {
          ForEach(Category.allCases, id: \.self) { category in
            VStack{
              Text(category.rawValue)
                .bold()
              Text("\(taskCount(for: category)) tasks")
  
                                          .font(.subheadline)
            }
                  .frame(width: 150, height: 150)
                  .background(Color.red)
                  .foregroundColor(.white)
                  .cornerRadius(10)
                  .onTapGesture {
                      if selectedCategory == category {
                          selectedCategory = nil
                      } else {
                          selectedCategory = category
                      }
                  }
          }
      }
      
        List(filteredCategories) { task in
          NavigationLink(value: task) {
            TaskRowView(task: $taskStore.tasks.first(where: { $0.id == task.id})!)
          }
        }
    }
  }
}

struct GridListView_Previews: PreviewProvider {
  static var previews: some View {
    GridView(taskStore: TaskStore())
  }
}
