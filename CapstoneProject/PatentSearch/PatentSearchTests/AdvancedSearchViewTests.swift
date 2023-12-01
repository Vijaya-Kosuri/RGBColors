

import Foundation

import XCTest
@testable import PatentSearch

class AdvancedSearchViewTests: XCTestCase {
  
  
  var sut: AdvancedSearchView!
  
  override func setUpWithError() throws {
    try super.setUpWithError()
    sut = AdvancedSearchView()
  }
  
  override func tearDownWithError() throws {
    sut = nil
    try super.tearDownWithError()
  }
  
  func testGetFormattedDate() {
    // Given
    let date = Date()
    
    
    let formattedDate = sut.getFormattedDate(date: date)
    print("form \(formattedDate)")
    
  }
  
  @MainActor func testAdvsearchPatents_WhenSuccess_ShouldUpdateResults() {
    let mockPatentStore = MockPatentStore()
    sut.patentStore = mockPatentStore
    sut.advsearchPatents()
    XCTAssertEqual(sut.advresults.count, 0)
  }
  
}

class MockPatentStore: PatentStore {
  var shouldFail = false
  var printedErrorMessage = ""
  
  func advfetchPatents(query: String, inventor: String, assignee: String, before: String, after: String, completion: @escaping (Result<SearchResponse, Error>) -> Void) {
    if shouldFail {
      let error = NSError(domain: "MockPatentStore", code: 1, userInfo: nil)
      completion(.failure(error))
    } else {
      let mockResponse = SearchResponse(organicResults: [OrganicResult]())
      completion(.success(mockResponse))
    }
  }
}

struct SearchResponse: Codable {
  let organicResults: [OrganicResult]
}
