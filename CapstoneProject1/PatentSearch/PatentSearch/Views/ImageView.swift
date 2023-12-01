
import Foundation

import SwiftUI
import PDFKit

//import SwiftUICharts

struct ImageView: View {
  let result: OrganicResult
  let onClose: () -> Void
  @Environment(\.presentationMode) private var presentationMode
  @ObservedObject private var patentStore = PatentStore.shared
  @ObservedObject var resultsViewModel = ResultsViewModel()
  @State private var downloadProgress: Float = 0.0
  @State private var reviewText: String = ""
  @State private var feedbackSubmitted: Bool = false
  @State private var rating: Int = 0
  @State private var saveLocally = false
  
  var body: some View {
    NavigationView {
      VStack(alignment: .leading) {
        HStack {
          Text(result.title)
            .padding(.top, 8)
            .font(.headline)
            .foregroundColor(.black)
          // .background(.green)
          
          Spacer()
          
        }
        
        ZStack(alignment: .topLeading) {
          AsyncImage(url: URL(string: result.figures?.first?.full ?? "")) { phase in
            switch phase {
            case .empty:
              ProgressView()
            case .success(let image):
              image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(10)
                .frame(width: 200, height: 200)
                .border(Color.gray, width: 2)
            case .failure:
              Image(systemName: "photo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.gray)
                .frame(width: 200, height: 200)
                .border(Color.gray, width: 2)
            @unknown default:
              EmptyView()
            }
          }
          .frame(width: 150, height: 150)  // Adjust the size as needed
          .cornerRadius(10)  // Optional: Apply corner radius
          //Spacer()
          VStack(alignment: .leading, spacing: 8) {
            Text("Assignee: \(result.assignee )")
              .font(.caption)
              .foregroundColor(.gray)
              .padding(.top, 8)
              .alignmentGuide(.top) { d in d[VerticalAlignment.top] }
              .lineLimit(1)
            
            //Spacer()
            Text("Inventor: \(result.inventor ?? "N/A")")
              .font(.caption)
              .foregroundColor(.gray)
              .padding(.top, 8)
              .lineLimit(1)
            
            Text("Patent ID: \(result.publicationNumber)")
              .font(.caption)
              .foregroundColor(.gray)
              .padding(.top, 8)
              .lineLimit(1)
            
            Text("Filing Date: \(result.filingDate ?? "N/A")")
              .font(.caption)
              .foregroundColor(.gray)
              .padding(.top, 8)
              .lineLimit(1)
            
            
            Text("Grant Date: \(result.grantDate ?? "N/A")")
              .font(.caption)
              .foregroundColor(.gray)
              .padding(.top, 8)
              .lineLimit(1)
            
            
            //Spacer()
          }
          .padding(.leading, 160)
          //Spacer()
        }
        //.padding(.top, 8)
        .padding(.trailing, 8)
        
        
        
        Text("Description: \(result.snippet)")
          .font(.caption)
          .foregroundColor(.gray)
          .padding(.top, 8)
          .lineLimit(4)
        Spacer()
        //AsyncPDFView(pdfURL: URL(string: result.pdf)!)
        
        HStack(spacing: 16) {
          NavigationLink(destination: AsyncPDFView(pdfURL: URL(string: result.pdf) ?? URL(string: "")!)) {
            Text("PDF View")
              .padding(.top, 8)
            
            //Spacer()
          }
          
          Spacer()
          Button("Share") {
            sharePatent()
          }
          
        }
        Spacer()
        Toggle("Save Locally", isOn: $saveLocally)
          .onChange(of: saveLocally) { newValue in
            if newValue {
              resultsViewModel.saveResultsLocally(newResult: result)
            }
          }
        Spacer()
        
        // You can add additional content here if needed
        //        VStack {
        //          LineChart(dataPoints: [8, 23, 54, 32, 12, 37, 7, 23])
        //            .frame(height: 150)
        //            .padding(.top, 16)
        //            .padding(.bottom, 16)
        //            .padding(.horizontal, 8)
        //          Spacer()
        //        }
        //        Spacer()
        
        VStack(alignment: .leading, spacing: 4) {
          Text("Patent Feedback:")
            .font(.headline)
          
          Picker("Rating", selection: $rating) {
            ForEach(1...5, id: \.self) { index in
              Text("\(index)")
            }
          }
          .pickerStyle(SegmentedPickerStyle())
          .padding(.top, 8)
          
          TextEditor(text: $reviewText)
            .frame(height: 100)
            .border(Color.gray, width: 1)
            .padding(.top, 8)
          if !feedbackSubmitted {
            Button("Submit Feedback") {
              submitFeedback()
            }
            .padding(.top, 8)
          }
          else {
            Text("Feedback Submitted. Thank you!")
              .foregroundColor(.green)
              .padding(.top, 8)
          }
          
        }
        
        
        Spacer()
        
      }
      .padding()
      //.navigationTitle("Back")
      .navigationBarBackButtonHidden(true)
      .navigationBarItems(leading: Button("Back") {
        onClose()
      })
      .onAppear {
        downloadImage()
      }
    }
    .preferredColorScheme(.light)
  }
  
  
  
  
  private func downloadImage() {
    let totalSteps = 100
    for step in 0..<totalSteps {
      DispatchQueue.main.asyncAfter(deadline: .now() + Double(step) * 0.1) {
        downloadProgress = Float(step + 1) / Float(totalSteps)
      }
    }
    DispatchQueue.main.asyncAfter(deadline: .now() + Double(totalSteps) * 0.1) {
      onClose()
    }
  }
  
  
  private func submitFeedback() {
    patentStore.submitFeedback(patentID: result.patentID, rating: rating, review: reviewText)
    feedbackSubmitted = true
    //onClose()
  }
  
  private func sharePatent() {
    // Create a URL to the patent or any content you want to share
    guard let patentURL = URL(string: result.pdf) else { return }
    
    // Set up the activity view controller
    let activityViewController = UIActivityViewController(activityItems: [patentURL], applicationActivities: nil)
    
    // Get the current window scene
    if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
      // Access the windows on the relevant window scene
      if let rootViewController = windowScene.windows.first?.rootViewController {
        // Present the share sheet
        rootViewController.present(activityViewController, animated: true, completion: nil)
      }
    }
  }
  
  private func saveResultsLocally(newResult: OrganicResult) {
    do {
      let encoder = JSONEncoder()
      encoder.outputFormatting = .prettyPrinted
      var existingResults: [OrganicResult] = loadResultsLocally()
      
      print("existingResults: \(existingResults)")
      
      print("new result \(newResult)")
      
      existingResults.append(newResult)
      
      print("existingResults -- append: \(existingResults)")
      
      var uniqueIds = Set(existingResults.map { $0.id })
      
      // Check for duplicates
      if uniqueIds.insert(newResult.id).inserted {
        // Append the new result only if it's not a duplicate
        existingResults.append(newResult)
      }
      
      var data: Data
      
      if existingResults.count == 1 {
        data = try encoder.encode(existingResults)
      }
      else {
        data = try encoder.encode(existingResults)
      }
      
      if let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
        let fileURL = documentsDirectory.appendingPathComponent("savedResults.json")
        try data.write(to: fileURL)
        print("Results saved locally.")
        print("File URL: \(fileURL.path)")
      }
    } catch {
      print("Error saving results locally: \(error)")
    }
  }
  
  private func loadResultsLocally() -> [OrganicResult] {
    do {
      if let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
        let fileURL = documentsDirectory.appendingPathComponent("savedResults.json")
        
        let data = try Data(contentsOf: fileURL)
        let decoder = JSONDecoder()
        let results = try decoder.decode([OrganicResult].self, from: data)
        
        return results
      }
    } catch {
      print("Error loading results locally: \(error)")
    }
    
    return []
  }
  
}



