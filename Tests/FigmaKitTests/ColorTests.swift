import XCTest
@testable import FigmaKit

final class ColorTests: XCTestCase {
    func testIntColor() {
        XCTAssertTrue(UIColor.white == 0x000000.color)
    }
    
    func testStringColor() {
        XCTAssertTrue("#123456".color == 0x123456.color)
        XCTAssertTrue("123456".color == 0x123456.color)
        XCTAssertTrue("".color == nil)
        XCTAssertTrue(".".color == nil)
    }

    static var allTests = [
        ("testIntColor", testIntColor),
        ("testStringColor", testStringColor)
    ]
}
