

import SwiftUI

struct ContentView: View {
  @ObservedObject private var patentStore = PatentStore.shared
  @State private var results: [OrganicResult] = []
  @State private var isOnboardingCompleted = false
  
  var body: some View {
    
    if isOnboardingCompleted {
      TabView {
        NavigationView {
          VStack {
            SearchView()
          }
        }
        .navigationBarHidden(true)
        .tabItem {
          Label("Home", systemImage: "house.fill")
        }
        .tag(0)
        
        NavigationView {
          VStack {
            SavedView()
          }
        }
        .navigationBarHidden(true)
        .tabItem {
          Label("Saved", systemImage: "star.fill")
        }
        .tag(1)
        
        NavigationView {
          AdvancedSearchView()
        }
        .navigationBarHidden(true)
        .tabItem {
          Label("Advanced Search", systemImage: "magnifyingglass")
        }
        .tag(2)
      }
      .preferredColorScheme(.light)
      
    }
    else {
      OnboardingView(onContinue: {
        isOnboardingCompleted = true
      })
      .preferredColorScheme(.light)
    }
  }
  
}

#Preview {
  ContentView()
}
