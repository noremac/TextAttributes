import TextAttributes
import XCTest

final class TextStyleTests: XCTestCase {
    func testParagraphStyleHasValueSemantics() {
        var s1 = TextAttributes()
        s1.lineSpacing = 100

        var s2 = s1
        s2.lineSpacing = 200

        XCTAssert(s1.lineSpacing == 100)
        XCTAssert(s2.lineSpacing == 200)

        s1.lineSpacing = 300
        XCTAssert(s1.lineSpacing == 300)
        XCTAssert(s2.lineSpacing == 200)
    }

    func testParagraphStyleIsCopied() {
        let style = TextAttributes {
            $0.lineSpacing = 10
        }
        let p1 = style.paragraphStyle!
        let p2 = style.paragraphStyle!
        XCTAssertNotEqual(ObjectIdentifier(p1), ObjectIdentifier(p2))
    }
}
