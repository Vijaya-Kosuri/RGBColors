

import XCTest

@testable import PatentSearch

final class PatentSearchUITests: XCTestCase {
  
  override func setUpWithError() throws {
    continueAfterFailure = false
  }
  
  func testExample() throws {
    let app = XCUIApplication()
    app.launch()
  }
  
  func testLaunchPerformance() throws {
    if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
      measure(metrics: [XCTApplicationLaunchMetric()]) {
        XCUIApplication().launch()
      }
    }
  }
  
  func testPDFViewRendering() throws {
    let app = XCUIApplication()
    app.launch()
    
    _ = app.otherElements["asyncPDFView"]
    
    _ = app.otherElements["pdfView"]
  }
  
  func testDetailedView() {
    let app = XCUIApplication()
    app.launch()
  }
  
  func testTappingOnResult_ShouldShowDetailedView() {
    
    let app = XCUIApplication()
    app.launch()
    
    _ = app.tables.cells.containing(.staticText, identifier: "tapview").firstMatch
    _ = app.otherElements["tapview"]
    
  }
  
}
