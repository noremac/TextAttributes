import UIKit

@dynamicMemberLookup
public struct TextStyle {

    static let defaultParagraphStyle = NSMutableParagraphStyle()

    var _paragraphStyle: NSMutableParagraphStyle!

    @usableFromInline var _attributes: [NSAttributedString.Key: Any] = [:]

    // MARK: Initializers

    public init() {}

    public init(_ builder: (inout TextStyle) -> Void) {
        builder(&self)
    }
}

// MARK: Equatable

extension TextStyle: Equatable {

    public static func == (lhs: TextStyle, rhs: TextStyle) -> Bool {
        return (lhs.attributes as NSDictionary).isEqual(to: rhs.attributes)
    }
}

public extension TextStyle {

    // MARK: Attributes

    @inlinable
    subscript<T>(key: NSAttributedString.Key) -> T? {
        get {
            assert(key != .paragraphStyle, "Please use the `.paragraphStyle` property directly.")
            return _attributes[key] as? T
        }
        set {
            assert(key != .paragraphStyle, "Please use the `.paragraphStyle` property directly.")
            _attributes[key] = newValue
        }
    }

    var attributes: [NSAttributedString.Key: Any] {
        if let style = paragraphStyle {
            var attributess = _attributes
            attributess[.paragraphStyle] = style
            return attributess
        } else {
            return _attributes
        }
    }

    // MARK: Font

    var font: UIFont? {
        get { self[.font] }
        set { self[.font] = newValue }
    }

    // MARK: Foreground color

    var foregroundColor: UIColor? {
        get { self[.foregroundColor] }
        set { self[.foregroundColor] = newValue }
    }

    // MARK: Background color

    var backgroundColor: UIColor? {
        get { self[.backgroundColor] }
        set { self[.backgroundColor] = newValue }
    }

    // MARK: Ligature

    var ligature: Int? {
        get { self[.ligature] }
        set { self[.ligature] = newValue }
    }

    // MARK: Kern

    var kern: CGFloat? {
        get { self[.kern] }
        set { self[.kern] = newValue }
    }

    // MARK: Strikethrough style

    var strikethroughStyle: NSUnderlineStyle? {
        get { self[.strikethroughStyle] }
        set { self[.strikethroughStyle] = newValue }
    }

    // MARK: Strikethrough color

    var strikethroughColor: UIColor? {
        get { self[.strikethroughColor] }
        set { self[.strikethroughColor] = newValue }
    }

    // MARK: Underline style

    var underlineStyle: NSUnderlineStyle? {
        get { self[.underlineStyle] }
        set { self[.underlineStyle] = newValue }
    }

    // MARK: Underline color

    var underlineColor: UIColor? {
        get { self[.underlineColor] }
        set { self[.underlineColor] = newValue }
    }

    // MARK: Stroke color

    var strokeColor: UIColor? {
        get { self[.strokeColor] }
        set { self[.strokeColor] = newValue }
    }

    // MARK: Stroke width

    var strokeWidth: CGFloat? {
        get { self[.strokeWidth] }
        set { self[.strokeWidth] = newValue }
    }

    // MARK: Shadow

    var shadow: NSShadow? {
        get { self[.shadow] }
        set { self[.shadow] = newValue }
    }

    // MARK: Text effect

    var textEffect: NSAttributedString.TextEffectStyle? {
        get { self[.textEffect] }
        set { self[.textEffect] = newValue }
    }

    // MARK: Attachment

    var attachment: NSTextAttachment? {
        get { self[.attachment] }
        set { self[.attachment] = newValue }
    }

    // MARK: Link

    var link: URL? {
        get { self[.link] }
        set { self[.link] = newValue }
    }

    // MARK: Baseline offset

    var baselineOffset: CGFloat? {
        get { self[.baselineOffset] }
        set { self[.baselineOffset] = newValue }
    }

    // MARK: Obliqueness

    var obliqueness: CGFloat? {
        get { self[.obliqueness] }
        set { self[.obliqueness] = newValue }
    }

    // MARK: Expansion

    var expansion: CGFloat? {
        get { self[.expansion] }
        set { self[.expansion] = newValue }
    }

    // MARK: Writing direction

    var writingDirection: [NSWritingDirection]? {
        get { self[.writingDirection] }
        set { self[.writingDirection] = newValue }
    }

    // MARK: Vertical glyph form

    var verticalGlyphForm: Int? {
        get { self[.verticalGlyphForm] }
        set { self[.verticalGlyphForm] = newValue }
    }
}

public extension TextStyle {

    // MARK: Paragraph style

    /// The paragraph style. New values will be copied upon being set.
    /// - Note: Prefer to use the specific properties on `TextStyle` for manipulating the paragraph
    /// style attributes; this property will override those values.
    var paragraphStyle: NSParagraphStyle? {
        get { _paragraphStyle?.copy() as? NSParagraphStyle }
        set { _paragraphStyle = newValue?.mutableCopy() as? NSMutableParagraphStyle }
    }

    subscript<T>(dynamicMember keyPath: WritableKeyPath<NSMutableParagraphStyle, T>) -> T {
        get {
            (_paragraphStyle ?? Self.defaultParagraphStyle)[keyPath: keyPath]
        }
        set {
            if _paragraphStyle == nil {
                _paragraphStyle = .init()
            } else if !isKnownUniquelyReferenced(&_paragraphStyle) {
                let style = _paragraphStyle.mutableCopy() as! NSMutableParagraphStyle
                _paragraphStyle = style
            }
            _paragraphStyle[keyPath: keyPath] = newValue
        }
    }
}

// MARK: String

public extension String {

    func attributedString(withStyle style: TextStyle) -> NSAttributedString {
        return .init(string: self, attributes: style.attributes)
    }
}
