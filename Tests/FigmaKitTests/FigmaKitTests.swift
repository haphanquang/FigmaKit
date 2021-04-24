import XCTest
@testable import FigmaKit

final class FigmaKitTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(FigmaKit().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
