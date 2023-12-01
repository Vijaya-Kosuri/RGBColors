
import XCTest
@testable import PatentSearch

class PatentFeedbackTests: XCTestCase {
  
  func testPatentFeedbackInitialization() {
    
    let patentID = "testID"
    let rating = 5
    let review = "Great patent!"
    
    let feedback = PatentFeedback(patentID: patentID, rating: rating, review: review)
    
    XCTAssertEqual(feedback.patentID, patentID)
    XCTAssertEqual(feedback.rating, rating)
    XCTAssertEqual(feedback.review, review)
    XCTAssertNotNil(feedback.id, "ID should be initialized")
  }
  
  func testPatentFeedbackIDUniqueness() {
    
    let feedback1 = PatentFeedback(patentID: "testID1", rating: 4, review: "Good")
    let feedback2 = PatentFeedback(patentID: "testID2", rating: 3, review: "Okay")
    
    XCTAssertNotEqual(feedback1.id, feedback2.id)
  }
}
