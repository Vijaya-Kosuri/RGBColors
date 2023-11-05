import Foundation
import SwiftUI
import PlaygroundSupport

struct CatFacts: Codable {
    let fact: String
}

struct CatFactsSequence: AsyncSequence {
  typealias AsyncIterator = CatFactsIterator
  typealias Element = CatFacts

  let count: Int

  func makeAsyncIterator() -> CatFactsIterator {
    return CatFactsIterator(count)
  }
}

struct CatFactsIterator: AsyncIteratorProtocol {
  typealias Element = CatFacts
  let count: Int
  private var currentCount = 0

  init(_ count: Int) {
    self.count = count
  }
  mutating func next() async throws -> CatFacts? {
      
    guard currentCount < count else { return nil }
                let response = try await fetchFacts()
                currentCount += 1
                return response
    }
}

func fetchFacts() async throws -> CatFacts {
    let url = URL(string: "https://catfact.ninja/fact")!
    let (data, _) = try await URLSession.shared.data(from: url)
    let decoder = JSONDecoder()
    let factResponse = try decoder.decode(CatFacts.self, from: data)
    return factResponse
}


func getFacts(count: Int) async throws -> [CatFacts] {
    var catFacts: [CatFacts] = []
    var iterator = CatFactsSequence(count: count).makeAsyncIterator()
    while let catFact = try await iterator.next() {
        catFacts.append(catFact)
    }
    return catFacts
}

PlaygroundPage.current.needsIndefiniteExecution = true

async {
    do {
        let catFacts = try await getFacts(count: 1)
        for fact in catFacts {
            print(fact.fact)
        }
    } catch {
        print("Error fetching Cat Facts: \(error)")
    }
}
