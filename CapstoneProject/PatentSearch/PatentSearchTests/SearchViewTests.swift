

import Foundation

import XCTest
@testable import PatentSearch

class SearchViewTests: XCTestCase {
  
  
  func testSearchView_WhenSearching_ShouldUpdateResults() {
    
    let searchView = SearchView()
    searchView.searchPatents(query: "Vijaya Kosuri")
    
    let resultsCount = searchView.results.count
    
    let expectedResultsCount =  0
    XCTAssertEqual(resultsCount, expectedResultsCount)
  }
}
