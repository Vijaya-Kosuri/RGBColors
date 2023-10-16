import SwiftUI

struct ContentView: View {
  
  var body: some View {
    TabView {
      APIView()
        .tabItem {
          Image(systemName: "app.badge")
            .resizable()
          Text("API's")
        }
      UserView()
        .tabItem {
          Image(systemName: "person.circle")
            .resizable()
          Text("Userview")
        }
    }
    
  }
  
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    Text("completed")
  }
}






