import XCTest
@testable import SwiftUIDictionary

final class SwiftUIDictionaryTests: XCTestCase {
    
    let definitions = [
        WordDefinition(word: "My Instagram", value: "@p.larson"),
        WordDefinition(word: "My Github", value: "@p-larson")
    ]
    
    func testSeperator() {
        let input = "Check out My Instagram!"
        let expected = ["Check out ", "My Instagram", "!"]
        let output = input.map(definitions: [definitions.first!]).map { $0.string }
        
        print(input, expected, output)
        
        XCTAssert(expected == output)
    }
    
    func testMultiSeperator() {
        let input = "Check out My Instagram or My Github!"
        let expected = ["Check out ", "My Instagram", " or ", "My Github", "!"]
        let output = input.map(definitions: definitions).map { $0.string }
        
        print(input, expected, output)
        
        XCTAssert(expected == output)
    }

    static var allTests = [
        ("testSeperator", testSeperator),
        ("testMultiSeperator", testMultiSeperator)
    ]
}
