
import Foundation

import SwiftUI

struct AdvancedSearchView: View {
  @State private var inventor: String = ""
  @State private var assignee: String = ""
  @State private var startDate: Date = Date()
  @State private var endDate: Date = Date()
  @ObservedObject var patentStore = PatentStore.shared
  @State private var startdateString: String = ""
  @State private var enddateString: String = ""
  @State private var showResults = false
  @State var advresults: [OrganicResult] = []
  
  
  
  var body: some View {
    
    NavigationView {
      Form {
        Section(header: Text("Inventor")) {
          TextField("Enter inventor's name", text: $inventor)
        }
        
        Section(header: Text("Assignee")) {
          TextField("Enter assignee's name", text: $assignee)
        }
        
        Section(header: Text("Date Range")) {
          DatePicker("Start Date", selection: $startDate, in: ...Date(), displayedComponents: .date)
            .onChange(of: startDate) {
              startdateString = getFormattedDate(date: startDate)
            }
          
          
          DatePicker("End Date", selection: $endDate, in: ...Date(), displayedComponents: .date)
            .onChange(of: endDate) {
              enddateString = getFormattedDate(date: endDate)
            }
        }
        
        
        Section {
          VStack {
            NavigationLink(destination: AdvancedDisplayView(results: advresults), isActive: $showResults) {
              EmptyView()
            }
            .opacity(0)
            
            Button(action: {
              // Perform search based on the entered criteria
              advsearchPatents()
              showResults = true
            }) {
              HStack {
                Spacer()
                Text("Search")
                  .foregroundColor(.primary)
                  .font(.headline)
                Spacer()
              }
            }
          }
        }
        
      }
      .navigationTitle("Advanced Search")
    }
  }
  
  func getFormattedDate(date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyymmdd"
    return dateFormatter.string(from: date)
  }
  
  
  func advsearchPatents() {
    PatentStore.shared.advfetchPatents(query: inventor, inventor: inventor, assignee: assignee, before: enddateString, after: startdateString ) { result in
      switch result {
      case .success(let response):
        DispatchQueue.main.async {
          self.advresults = response.organicResults
          print("queue")
        }
      case .failure(let error):
        print("Error fetching patents: \(error)")
      }
    }
  }
}

struct AdvancedSearchView_Previews: PreviewProvider {
  static var previews: some View {
    AdvancedSearchView()
  }
}
