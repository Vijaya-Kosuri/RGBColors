//
//  TaskListApp.swift
//  TaskList
//
//  Created by Srinivas Pala on 9/30/23.
//

import SwiftUI

@main
struct TaskListApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: Store())
        }
    }
}
