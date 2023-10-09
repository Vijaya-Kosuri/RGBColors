//
//  ContentView.swift
//  Chapter13
//
//  Created by Srinivas Pala on 10/4/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
      NavigationSplitView {
        Text("Sidebar")
      } detail: {
        Text("Detail")
      }
    }
}

#Preview {
    ContentView()
}
