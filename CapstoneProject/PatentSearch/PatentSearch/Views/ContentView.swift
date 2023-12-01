

import SwiftUI



struct ContentView: View {
  @ObservedObject private var patentStore = PatentStore.shared
  @State private var results: [OrganicResult] = []
  @State var isOnboardingCompleted = false
  @Environment(\.colorScheme) var colorScheme
  @Environment(\.verticalSizeClass) var verticalSizeClass
  @Environment(\.horizontalSizeClass) var horizontalSizeClass
  
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
      .environment(\.horizontalSizeClass, horizontalSizeClass)
      .environment(\.verticalSizeClass, verticalSizeClass)
      
    }
    else {
      OnboardingView(onContinue: {
        isOnboardingCompleted = true
      })
      
    }
  }
  
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
    ContentView()
      .preferredColorScheme(.dark)
    
    
  }
}
