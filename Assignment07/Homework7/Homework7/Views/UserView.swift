import Foundation

import SwiftUI

struct UserView: View {
  @ObservedObject var userStore = UserStore()
  
  
  var body: some View {
    
    VStack(alignment: .leading, spacing: 20) {
      List(userStore.users) { user in
        Text(user.name.first)
        Text(user.name.last)
        Text(user.email)
        Text(user.gender)
        Text(user.phone)
        Spacer()
      }
    }
    .padding()
    .navigationBarTitle("User Details")
    .onAppear {
      userStore.loadJSONData()
    }
  }
  
}
