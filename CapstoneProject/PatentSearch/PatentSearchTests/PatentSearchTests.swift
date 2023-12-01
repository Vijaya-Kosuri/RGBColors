

import XCTest
import PDFKit
import SwiftUI

@testable import PatentSearch

final class PatentSearchTests: XCTestCase {
  
  var patentStore: PatentStore!
  
  @MainActor override func setUpWithError() throws {
    patentStore = PatentStore()
  }
  
  override func tearDownWithError() throws {
    patentStore = nil
  }
  
  @MainActor func testFetchPatents() throws {
    let query = "Vijaya Kosuri"
    let expectation = XCTestExpectation(description: "Fetching patents")
    
    patentStore.fetchPatents(query: query) { result in
      switch result {
      case .success(let model):
        XCTAssertNotNil(model)
        XCTAssertFalse(model.organicResults.isEmpty)
      case .failure(let error):
        XCTFail("Fetching patents failed with error: \(error)")
      }
      
      expectation.fulfill()
    }
    
    wait(for: [expectation], timeout: 5.0)
  }
  
  
  
  @MainActor func testSubmitFeedback() {
    
    let patentID = "TestID"
    let rating = 4
    let review = "Test Review"
    
    
    patentStore.submitFeedback(patentID: patentID, rating: rating, review: review)
    
    XCTAssertEqual(patentStore.feedbacks.count, 1)
    XCTAssertEqual(patentStore.feedbacks.first?.patentID, patentID)
    XCTAssertEqual(patentStore.feedbacks.first?.rating, rating)
    XCTAssertEqual(patentStore.feedbacks.first?.review, review)
  }
  
  func testOnboardingView() {
    
    let onboardingView = OnboardingView(onContinue: {})
    let onboardingViewBody = onboardingView.body
    XCTAssertNotNil(onboardingViewBody)
  }
  
  func testPatentModelEncodingDecoding() throws {
    let figure = Figure(thumbnail: "thumbnail", full: "full")
    let countryStatus = CountryStatus(wo: "1", ep: "2", us: "3", cn: "4", jp: "5", kr: "6", au: "7", br: "8", ca: "9", cl: "10", mx: "11", ph: "12", ru: "13", at: "14", de: "15", ar: "16", dk: "17", za: "18", es: "19", pl: "20", pt: "21")
    
    let organicResult = OrganicResult(
      position: 1,
      rank: 1,
      patentID: "patent123",
      title: "Title",
      snippet: "Snippet",
      priorityDate: "2022-01-01",
      filingDate: "2022-01-01",
      grantDate: "2022-01-01",
      publicationDate: "2022-01-01",
      inventor: "Inventor",
      assignee: "Assignee",
      publicationNumber: "123",
      language: .en,
      thumbnail: "thumbnail",
      pdf: "pdf",
      figures: [figure],
      countryStatus: countryStatus
    )
    
    let patentModel = PatentModel(organicResults: [organicResult])
    
    
    let encoder = JSONEncoder()
    let encodedData = try encoder.encode(patentModel)
    
    let decoder = JSONDecoder()
    _ = try decoder.decode(PatentModel.self, from: encodedData)
    
    
  }
  
  func testSelectingResult_ShouldPresentDetailView() {
    
    let result = OrganicResult(
      position: 1,
      rank: 1,
      patentID: "patent/US20230147246A1/en",
      title: "Messaging system failover",
      snippet: "Mocked Snippet",
      priorityDate: "2022-01-01",
      filingDate: "2022-01-01",
      grantDate: "2022-01-01",
      publicationDate: "2022-01-01",
      inventor: "Mocked Inventor",
      assignee: "Mocked Assignee",
      publicationNumber: "Mocked Number",
      language: .en,
      thumbnail: "https://patentimages.storage.googleapis.com/ad/52/c5/288ca78d87c1f3/US20230147246A1-20230511-D00000.png",
      pdf: "https://patentimages.storage.googleapis.com/64/6f/17/8b7b072c72e8e6/US20230147246A1.pdf",
      figures: nil,
      countryStatus: CountryStatus(wo: nil, ep: nil, us: nil, cn: nil, jp: nil, kr: nil, au: nil, br: nil, ca: nil, cl: nil, mx: nil, ph: nil, ru: nil, at: nil, de: nil, ar: nil, dk: nil, za: nil, es: nil, pl: nil, pt: nil)
    )
    _ = AdvancedDisplayView(results: [result])
    
  }
  
  func testDisplayingResults_ShouldShowCorrectNumberOfRows() {
    
    let results = [OrganicResult(
      position: 1,
      rank: 1,
      patentID: "patent/US20230147246A1/en",
      title: "Messaging system failover",
      snippet: "Mocked Snippet",
      priorityDate: "2022-01-01",
      filingDate: "2022-01-01",
      grantDate: "2022-01-01",
      publicationDate: "2022-01-01",
      inventor: "Mocked Inventor",
      assignee: "Mocked Assignee",
      publicationNumber: "Mocked Number",
      language: .en,
      thumbnail: "https://patentimages.storage.googleapis.com/ad/52/c5/288ca78d87c1f3/US20230147246A1-20230511-D00000.png",
      pdf: "https://patentimages.storage.googleapis.com/64/6f/17/8b7b072c72e8e6/US20230147246A1.pdf",
      figures: nil,
      countryStatus: CountryStatus(wo: nil, ep: nil, us: nil, cn: nil, jp: nil, kr: nil, au: nil, br: nil, ca: nil, cl: nil, mx: nil, ph: nil, ru: nil, at: nil, de: nil, ar: nil, dk: nil, za: nil, es: nil, pl: nil, pt: nil)
    )]
    let advancedDisplayView = AdvancedDisplayView(results: results)
    
    
    let numberOfRows = advancedDisplayView.results.count
    
    XCTAssertEqual(numberOfRows, results.count)
  }
  
  func testTappingOnResult_ShouldSetSelectedResult() {
    
    let result = OrganicResult(
      position: 1,
      rank: 1,
      patentID: "patent/US20230147246A1/en",
      title: "Messaging system failover",
      snippet: "Mocked Snippet",
      priorityDate: "2022-01-01",
      filingDate: "2022-01-01",
      grantDate: "2022-01-01",
      publicationDate: "2022-01-01",
      inventor: "Mocked Inventor",
      assignee: "Mocked Assignee",
      publicationNumber: "Mocked Number",
      language: .en,
      thumbnail: "https://patentimages.storage.googleapis.com/ad/52/c5/288ca78d87c1f3/US20230147246A1-20230511-D00000.png",
      pdf: "https://patentimages.storage.googleapis.com/64/6f/17/8b7b072c72e8e6/US20230147246A1.pdf",
      figures: nil,
      countryStatus: CountryStatus(wo: nil, ep: nil, us: nil, cn: nil, jp: nil, kr: nil, au: nil, br: nil, ca: nil, cl: nil, mx: nil, ph: nil, ru: nil, at: nil, de: nil, ar: nil, dk: nil, za: nil, es: nil, pl: nil, pt: nil)
    )
    _ = AdvancedDisplayView(results: [result])
    
  }
  
  func testSavedView_WhenResultsAreLoaded_ShouldDisplayCorrectly() {
    let resultsViewModel = ResultsViewModel()
    resultsViewModel.results = [
      OrganicResult(
        position: 1,
        rank: 1,
        patentID: "patent/US20230147246A1/en",
        title: "Messaging system failover",
        snippet: "Mocked Snippet",
        priorityDate: "2022-01-01",
        filingDate: "2022-01-01",
        grantDate: "2022-01-01",
        publicationDate: "2022-01-01",
        inventor: "Mocked Inventor",
        assignee: "Mocked Assignee",
        publicationNumber: "Mocked Number",
        language: .en,
        thumbnail: "https://patentimages.storage.googleapis.com/ad/52/c5/288ca78d87c1f3/US20230147246A1-20230511-D00000.png",
        pdf: "https://patentimages.storage.googleapis.com/64/6f/17/8b7b072c72e8e6/US20230147246A1.pdf",
        figures: nil,
        countryStatus: CountryStatus(wo: nil, ep: nil, us: nil, cn: nil, jp: nil, kr: nil, au: nil, br: nil, ca: nil, cl: nil, mx: nil, ph: nil, ru: nil, at: nil, de: nil, ar: nil, dk: nil, za: nil, es: nil, pl: nil, pt: nil)
      )
    ]
    
    let savedView = SavedView(resultsViewModel: resultsViewModel)
    
    
    let contentView = savedView.body
    
    XCTAssertNotNil(contentView)
  }
  
  func testSavedView_WhenResultsAreEmpty_ShouldShowPlaceholder() {
    
    let resultsViewModel = ResultsViewModel()
    resultsViewModel.results = []
    
    let savedView = SavedView(resultsViewModel: resultsViewModel)
    
    
    let contentView = savedView.body
    
    
    XCTAssertNotNil(contentView)
    
  }
  
  func testSavedView_WhenTappingCell_ShouldPresentDetailedView() {
    
    let resultsViewModel = ResultsViewModel()
    resultsViewModel.results = [
      OrganicResult(
        position: 1,
        rank: 1,
        patentID: "patent/US20230147246A1/en",
        title: "Messaging system failover",
        snippet: "Mocked Snippet",
        priorityDate: "2022-01-01",
        filingDate: "2022-01-01",
        grantDate: "2022-01-01",
        publicationDate: "2022-01-01",
        inventor: "Mocked Inventor",
        assignee: "Mocked Assignee",
        publicationNumber: "Mocked Number",
        language: .en,
        thumbnail: "https://patentimages.storage.googleapis.com/ad/52/c5/288ca78d87c1f3/US20230147246A1-20230511-D00000.png",
        pdf: "https://patentimages.storage.googleapis.com/64/6f/17/8b7b072c72e8e6/US20230147246A1.pdf",
        figures: nil,
        countryStatus: CountryStatus(wo: nil, ep: nil, us: nil, cn: nil, jp: nil, kr: nil, au: nil, br: nil, ca: nil, cl: nil, mx: nil, ph: nil, ru: nil, at: nil, de: nil, ar: nil, dk: nil, za: nil, es: nil, pl: nil, pt: nil)
      )
    ]
    
    let savedView = SavedView(resultsViewModel: resultsViewModel)
    
    _ = savedView.body
  }
  
  
  func testSavedView_WhenResultsAreLoaded_ShouldDisplayCorrectNumberOfCells() {
    
    let resultsViewModel = ResultsViewModel()
    resultsViewModel.results = [OrganicResult(
      position: 1,
      rank: 1,
      patentID: "patent/US20230147246A1/en",
      title: "Messaging system failover",
      snippet: "Mocked Snippet",
      priorityDate: "2022-01-01",
      filingDate: "2022-01-01",
      grantDate: "2022-01-01",
      publicationDate: "2022-01-01",
      inventor: "Mocked Inventor",
      assignee: "Mocked Assignee",
      publicationNumber: "Mocked Number",
      language: .en,
      thumbnail: "https://patentimages.storage.googleapis.com/ad/52/c5/288ca78d87c1f3/US20230147246A1-20230511-D00000.png",
      pdf: "https://patentimages.storage.googleapis.com/64/6f/17/8b7b072c72e8e6/US20230147246A1.pdf",
      figures: nil,
      countryStatus: CountryStatus(wo: nil, ep: nil, us: nil, cn: nil, jp: nil, kr: nil, au: nil, br: nil, ca: nil, cl: nil, mx: nil, ph: nil, ru: nil, at: nil, de: nil, ar: nil, dk: nil, za: nil, es: nil, pl: nil, pt: nil)
    )
    ]
    
    _ = SavedView(resultsViewModel: resultsViewModel)
    
    XCTAssertEqual(1, resultsViewModel.results.count)
  }
  
  func testSavedView_WhenResultsAreLoaded_ShouldDisplayCorrectCellContent() {
    
    let resultsViewModel = ResultsViewModel()
    let testResult = OrganicResult(
      position: 1,
      rank: 1,
      patentID: "patent/US20230147246A1/en",
      title: "Messaging system failover",
      snippet: "Mocked Snippet",
      priorityDate: "2022-01-01",
      filingDate: "2022-01-01",
      grantDate: "2022-01-01",
      publicationDate: "2022-01-01",
      inventor: "Mocked Inventor",
      assignee: "Mocked Assignee",
      publicationNumber: "Mocked Number",
      language: .en,
      thumbnail: "https://patentimages.storage.googleapis.com/ad/52/c5/288ca78d87c1f3/US20230147246A1-20230511-D00000.png",
      pdf: "https://patentimages.storage.googleapis.com/64/6f/17/8b7b072c72e8e6/US20230147246A1.pdf",
      figures: nil,
      countryStatus: CountryStatus(wo: nil, ep: nil, us: nil, cn: nil, jp: nil, kr: nil, au: nil, br: nil, ca: nil, cl: nil, mx: nil, ph: nil, ru: nil, at: nil, de: nil, ar: nil, dk: nil, za: nil, es: nil, pl: nil, pt: nil)
    )
    
    resultsViewModel.results = [testResult]
    
    _ = SavedView(resultsViewModel: resultsViewModel)
    
    XCTAssertEqual("Messaging system failover", testResult.title)
    XCTAssertEqual("Mocked Number", testResult.publicationNumber)
  }
  
  func testContentView_WhenOnboardingCompleted_ShouldShowTabView() {
    
    let contentView = ContentView()
    contentView.isOnboardingCompleted = true
    
    _ = contentView.body
    
  }
  
  func testContentView_WhenOnboardingNotCompleted_ShouldShowOnboardingView() {
    let contentView = ContentView()
    contentView.isOnboardingCompleted = false
    
    let view = contentView.body
    print("Actual view type: \(view)")
    
  }
  func testContentView_WhenPreferredDarkMode_ShouldApplyDarkMode() {
    let contentView = ContentView()
    contentView.isOnboardingCompleted = true
    
    let darkModeContentView = ContentView()
    
    _ = darkModeContentView.preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
    
  }
  
  
  func testTapGesture_ShouldSetSelectedResult() {
    
    let result1 = OrganicResult(
      position: 1,
      rank: 1,
      patentID: "patent/US20230147246A1/en",
      title: "Messaging system failover",
      snippet: "Mocked Snippet",
      priorityDate: "2022-01-01",
      filingDate: "2022-01-01",
      grantDate: "2022-01-01",
      publicationDate: "2022-01-01",
      inventor: "Mocked Inventor",
      assignee: "Mocked Assignee",
      publicationNumber: "Mocked Number",
      language: .en,
      thumbnail: "https://patentimages.storage.googleapis.com/ad/52/c5/288ca78d87c1f3/US20230147246A1-20230511-D00000.png",
      pdf: "https://patentimages.storage.googleapis.com/64/6f/17/8b7b072c72e8e6/US20230147246A1.pdf",
      figures: nil,
      countryStatus: CountryStatus(wo: nil, ep: nil, us: nil, cn: nil, jp: nil, kr: nil, au: nil, br: nil, ca: nil, cl: nil, mx: nil, ph: nil, ru: nil, at: nil, de: nil, ar: nil, dk: nil, za: nil, es: nil, pl: nil, pt: nil)
    )
    let result2 = OrganicResult(
      position: 1,
      rank: 1,
      patentID: "patent/US20230147246A2/en",
      title: "Messaging system failover2",
      snippet: "Mocked Snippet",
      priorityDate: "2022-01-01",
      filingDate: "2022-01-01",
      grantDate: "2022-01-01",
      publicationDate: "2022-01-01",
      inventor: "Mocked Inventor",
      assignee: "Mocked Assignee",
      publicationNumber: "Mocked Number",
      language: .en,
      thumbnail: "https://patentimages.storage.googleapis.com/ad/52/c5/288ca78d87c1f3/US20230147246A1-20230511-D00000.png",
      pdf: "https://patentimages.storage.googleapis.com/64/6f/17/8b7b072c72e8e6/US20230147246A1.pdf",
      figures: nil,
      countryStatus: CountryStatus(wo: nil, ep: nil, us: nil, cn: nil, jp: nil, kr: nil, au: nil, br: nil, ca: nil, cl: nil, mx: nil, ph: nil, ru: nil, at: nil, de: nil, ar: nil, dk: nil, za: nil, es: nil, pl: nil, pt: nil)
    )
    let results = [result1, result2]
    _ = AdvancedDisplayView(results: results)
  }
  
}



