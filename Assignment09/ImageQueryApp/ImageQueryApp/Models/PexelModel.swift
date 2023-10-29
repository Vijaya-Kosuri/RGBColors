
struct PexelsResponse: Decodable {
  let page, per_page, total_results: Int
  let photos: [PexelsPhoto]
  let next_page: String
  
  enum CodingKeys: String, CodingKey {
    case page
    case per_page
    case total_results
    case photos
    case next_page
  }
}

struct PexelsPhoto: Codable, Identifiable {
  let id, width, height: Int
  let url, photographer, photographer_url: String
  let photographer_id: Int
  let avg_color: String
  let src: PhotoSource
  let liked: Bool
  let alt: String
  
  struct PhotoSource: Codable {
    let original, large2x, large, medium, small, portrait, landscape, tiny: String
  }
}
