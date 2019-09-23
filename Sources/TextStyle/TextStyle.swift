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

    public var attributes: [NSAttributedString.Key: Any] {
        if let style = paragraphStyle {
            var attributess = _attributes
            attributess[.paragraphStyle] = style
            return attributess
        } else {
            return _attributes
        }
    }
}

// MARK: Attributes

public extension TextStyle {

    @inlinable
    subscript<T>(key: NSAttributedString.Key) -> T? {
        get { _attributes[key] as? T }
        set { _attributes[key] = newValue }
    }

    var font: UIFont? {
        get { self[.font] }
        set { self[.font] = newValue }
    }

    /// The paragraph style. New values will be copied upon being set.
    /// - Note: Prefer to use the specific properties on `TextStyle` for manipulating the paragraph
    /// style attributes; this property will override those values.
    var paragraphStyle: NSParagraphStyle? {
        get { _paragraphStyle?.copy() as? NSParagraphStyle }
        set { _paragraphStyle = newValue?.mutableCopy() as? NSMutableParagraphStyle }
    }

    var foregroundColor: UIColor? {
        get { self[.foregroundColor] }
        set { self[.foregroundColor] = newValue }
    }

    var backgroundColor: UIColor? {
        get { self[.backgroundColor] }
        set { self[.backgroundColor] = newValue }
    }

    var ligature: Int? {
        get { self[.ligature] }
        set { self[.ligature] = newValue }
    }

    var kern: CGFloat? {
        get { self[.kern] }
        set { self[.kern] = newValue }
    }

    var strikethroughStyle: NSUnderlineStyle? {
        get { self[.strikethroughStyle] }
        set { self[.strikethroughStyle] = newValue }
    }

    var strikethroughColor: UIColor? {
        get { self[.strikethroughColor] }
        set { self[.strikethroughColor] = newValue }
    }

    var underlineStyle: NSUnderlineStyle? {
        get { self[.underlineStyle] }
        set { self[.underlineStyle] = newValue }
    }

    var underlineColor: UIColor? {
        get { self[.underlineColor] }
        set { self[.underlineColor] = newValue }
    }

    var strokeColor: UIColor? {
        get { self[.strokeColor] }
        set { self[.strokeColor] = newValue }
    }

    var strokeWidth: CGFloat? {
        get { self[.strokeWidth] }
        set { self[.strokeWidth] = newValue }
    }

    var shadow: NSShadow? {
        get { self[.shadow] }
        set { self[.shadow] = newValue }
    }

    var textEffect: NSAttributedString.TextEffectStyle? {
        get { self[.textEffect] }
        set { self[.textEffect] = newValue }
    }

    var attachment: NSTextAttachment? {
        get { self[.attachment] }
        set { self[.attachment] = newValue }
    }

    var link: URL? {
        get { self[.link] }
        set { self[.link] = newValue }
    }

    var baselineOffset: CGFloat? {
        get { self[.baselineOffset] }
        set { self[.baselineOffset] = newValue }
    }

    var obliqueness: CGFloat? {
        get { self[.obliqueness] }
        set { self[.obliqueness] = newValue }
    }

    var expansion: CGFloat? {
        get { self[.expansion] }
        set { self[.expansion] = newValue }
    }

    var writingDirection: [NSWritingDirection]? {
        get { self[.writingDirection] }
        set { self[.writingDirection] = newValue }
    }

    var verticalGlyphForm: Int? {
        get { self[.verticalGlyphForm] }
        set { self[.verticalGlyphForm] = newValue }
    }
}

// MARK: Paragraph style

public extension TextStyle {

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
