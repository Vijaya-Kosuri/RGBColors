import XCTest
@testable import PatentSearch

class DetailedViewTests: XCTestCase {
  
  class MockResultsViewModel: ResultsViewModel {
    
    var saveResultsLocallyCalled = false
    var submitFeedbackCalled = false
    
    override func saveResultsLocally(newResult: OrganicResult) {
      saveResultsLocallyCalled = true
    }
    
    func submitFeedback(patentID: String, rating: Int, review: String) {
      submitFeedbackCalled = true
    }
    
    
  }
  
  func testDownloadImage() {
    
    let yourMockedOrganicResult = OrganicResult(
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
    let detailedView = DetailedView(result: yourMockedOrganicResult, onClose: {}, resultsViewModel: MockResultsViewModel())
    
    detailedView.downloadImage()
    
  }
  
  func testSaveResultsLocally() {
    let yourMockedOrganicResult = OrganicResult(
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
    let mockResultsViewModel = MockResultsViewModel()
    let detailedView = DetailedView(result: yourMockedOrganicResult, onClose: {}, resultsViewModel: mockResultsViewModel)
    
    detailedView.saveResultsLocally(newResult: yourMockedOrganicResult)
  }
  
  func testSubmitFeedback() {
    let yourMockedOrganicResult = OrganicResult(
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
    let mockResultsViewModel = MockResultsViewModel()
    let detailedView = DetailedView(result: yourMockedOrganicResult, onClose: {}, resultsViewModel: mockResultsViewModel)
    
    detailedView.submitFeedback()
  }
  
}
