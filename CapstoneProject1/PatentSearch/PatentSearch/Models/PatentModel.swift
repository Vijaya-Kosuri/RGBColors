

import Foundation

import Foundation


struct PatentModel : Codable {

    let organicResults: [OrganicResult]

  
  private enum CodingKeys: String, CodingKey {
      case organicResults = "organic_results"
  }
}


struct OrganicResult : Codable, Identifiable {
    var id: String { patentID }
    let position, rank: Int
    let patentID, title, snippet, priorityDate: String
    let filingDate, grantDate, publicationDate, inventor: String?
    let assignee, publicationNumber: String
    let language: Language
    let thumbnail: String
    let pdf: String
    let figures: [Figure]?
    let countryStatus: CountryStatus
  
    private enum CodingKeys: String, CodingKey {
      case patentID = "patent_id"
      case priorityDate = "priority_date"
      case filingDate = "filing_date"
      case publicationDate = "publication_date"
      case publicationNumber = "publication_number"
      case grantDate = "grant_date"
      case position, rank, title, snippet, inventor, assignee, language, thumbnail, pdf, figures
      case countryStatus = "country_status"
    }
}


struct CountryStatus : Codable {
    let wo, ep, us, cn: String?
    let jp, kr, au, br: String?
    let ca, cl, mx, ph: String?
    let ru, at, de, ar: String?
    let dk, za, es, pl: String?
    let pt: String?
}


struct Figure : Codable {
    let thumbnail, full: String
}

enum Language : Codable {
    case en
  case string(String) // Handle the case where it's a string
      
      init(from decoder: Decoder) throws {
          if let stringValue = try? decoder.singleValueContainer().decode(String.self) {
              self = .string(stringValue)
          } else {
              self = .en // Fallback to a default value if it's not a string
          }
      }
      
      func encode(to encoder: Encoder) throws {
          var container = encoder.singleValueContainer()
          switch self {
          case .en:
              try container.encode("en")
          case .string(let stringValue):
              try container.encode(stringValue)
          }
      }
}

