import XCTest
@testable import TextStyle

final class TextStyleTests: XCTestCase {
    func testParagraphStyleHasValueSemantics() {
        var s1 = TextStyle()
        s1.lineSpacing = 100
        var s2 = s1
        s2.lineSpacing = 200
        XCTAssert(s1.lineSpacing == 100)
        XCTAssert(s2.lineSpacing == 200)
        s1.lineSpacing = 300
        XCTAssert(s1.lineSpacing == 300)
        XCTAssert(s2.lineSpacing == 200)
    }
    
    func testEqualityNSDictionaryAssumptions() {
        XCTAssertEqual(TextStyle(), TextStyle())
        XCTAssertEqual(TextStyle { $0.lineSpacing = 2 }, TextStyle { $0.lineSpacing = 2 })
        XCTAssertNotEqual(TextStyle { $0.lineSpacing = 2 }, TextStyle { $0.lineSpacing = 1 })
        XCTAssertEqual(TextStyle { $0.foregroundColor = .blue }, TextStyle { $0.foregroundColor = .blue })
        XCTAssertNotEqual(TextStyle { $0.foregroundColor = .blue }, TextStyle { $0.foregroundColor = .red })
    }
}
