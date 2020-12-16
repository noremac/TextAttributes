#if canImport(UIKit)
import UIKit
public typealias TextStyleFont = UIFont
public typealias TextStyleColor = UIColor
#elseif canImport(AppKit)
import AppKit
public typealias TextStyleFont = NSFont
public typealias TextStyleColor = NSColor
#else
#error("unsupported platform")
#endif

@dynamicMemberLookup
public struct TextStyle {

    static let defaultParagraphStyle = NSMutableParagraphStyle()

    @usableFromInline
    var _paragraphStyle: NSMutableParagraphStyle!

    @usableFromInline
    var _attributes: [NSAttributedString.Key: Any] = [:]

    // MARK: Initializers

    public init() {}

    public init(_ builder: (inout TextStyle) -> Void) {
        builder(&self)
    }
}

// MARK: Equatable

extension TextStyle: Equatable {
    public static func == (lhs: TextStyle, rhs: TextStyle) -> Bool {
        (lhs.attributes as NSDictionary).isEqual(to: rhs.attributes)
    }
}

public extension TextStyle {
    // MARK: Attributes

    /// Set the given attribute for the given key.
    /// - Parameters:
    ///   - attribute: The attribute.
    ///   - key: The key.
    /// - Note: Prefer the type safe proprties. Only use this for instances
    /// where Apple has added a new property that this library does not yet
    /// support.
    @inlinable
    mutating func setAttribute(_ attribute: Any?, forKey key: NSAttributedString.Key) {
        assert(key != .paragraphStyle, "Please use the paragraph style property")
        _attributes[key] = attribute
    }

    @inlinable
    func attribute(forKey key: NSAttributedString.Key) -> Any? {
        if key == .paragraphStyle {
            return _paragraphStyle?.copy() as? NSParagraphStyle
        } else {
            return _attributes[key]
        }
    }

    @inlinable
    internal subscript<T>(key: NSAttributedString.Key) -> T? {
        get { _attributes[key] as? T }
        set { _attributes[key] = newValue }
    }

    @inlinable
    var attributes: [NSAttributedString.Key: Any] {
        if let style = paragraphStyle {
            var attributess = _attributes
            attributess[.paragraphStyle] = style.copy()
            return attributess
        } else {
            return _attributes
        }
    }

    // MARK: Font

    @inlinable
    var font: TextStyleFont? {
        get { self[.font] }
        set { self[.font] = newValue }
    }

    // MARK: Foreground color

    @inlinable
    var foregroundColor: TextStyleColor? {
        get { self[.foregroundColor] }
        set { self[.foregroundColor] = newValue }
    }

    // MARK: Background color

    @inlinable
    var backgroundColor: TextStyleColor? {
        get { self[.backgroundColor] }
        set { self[.backgroundColor] = newValue }
    }

    // MARK: Ligature

    @inlinable
    var ligature: Int? {
        get { self[.ligature] }
        set { self[.ligature] = newValue }
    }

    // MARK: Kern

    @inlinable
    var kern: CGFloat? {
        get { self[.kern] }
        set { self[.kern] = newValue }
    }

    // MARK: Strikethrough style

    @inlinable
    var strikethroughStyle: NSUnderlineStyle? {
        get { self[.strikethroughStyle] }
        set { self[.strikethroughStyle] = newValue }
    }

    // MARK: Strikethrough color

    @inlinable
    var strikethroughColor: TextStyleColor? {
        get { self[.strikethroughColor] }
        set { self[.strikethroughColor] = newValue }
    }

    // MARK: Underline style

    @inlinable
    var underlineStyle: NSUnderlineStyle? {
        get { self[.underlineStyle] }
        set { self[.underlineStyle] = newValue }
    }

    // MARK: Underline color

    @inlinable
    var underlineColor: TextStyleColor? {
        get { self[.underlineColor] }
        set { self[.underlineColor] = newValue }
    }

    // MARK: Stroke color

    @inlinable
    var strokeColor: TextStyleColor? {
        get { self[.strokeColor] }
        set { self[.strokeColor] = newValue }
    }

    // MARK: Stroke width

    @inlinable
    var strokeWidth: CGFloat? {
        get { self[.strokeWidth] }
        set { self[.strokeWidth] = newValue }
    }

    // MARK: Shadow

    @inlinable
    var shadow: NSShadow? {
        get { self[.shadow] }
        set { self[.shadow] = newValue }
    }

    // MARK: Text effect

    @inlinable
    var textEffect: NSAttributedString.TextEffectStyle? {
        get { self[.textEffect] }
        set { self[.textEffect] = newValue }
    }

    #if !os(watchOS)
    // MARK: Attachment

    @inlinable
    var attachment: NSTextAttachment? {
        get { self[.attachment] }
        set { self[.attachment] = newValue }
    }
    #endif

    // MARK: Link

    @inlinable
    var link: URL? {
        get { self[.link] }
        set { self[.link] = newValue }
    }

    // MARK: Baseline offset

    @inlinable
    var baselineOffset: CGFloat? {
        get { self[.baselineOffset] }
        set { self[.baselineOffset] = newValue }
    }

    // MARK: Obliqueness

    @inlinable
    var obliqueness: CGFloat? {
        get { self[.obliqueness] }
        set { self[.obliqueness] = newValue }
    }

    // MARK: Expansion

    @inlinable
    var expansion: CGFloat? {
        get { self[.expansion] }
        set { self[.expansion] = newValue }
    }

    // MARK: Writing direction

    @inlinable
    var writingDirection: [NSWritingDirection]? {
        get { self[.writingDirection] }
        set { self[.writingDirection] = newValue }
    }

    // MARK: Vertical glyph form

    @inlinable
    var verticalGlyphForm: Int? {
        get { self[.verticalGlyphForm] }
        set { self[.verticalGlyphForm] = newValue }
    }

    // MARK: Paragraph style

    /// The paragraph style. New values will be copied upon being set.
    /// - Note: Prefer to use the specific properties on `TextStyle` for manipulating the paragraph
    /// style attributes; this property will override those values.
    @inlinable
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
        NSAttributedString(string: self, attributes: style.attributes)
    }

    func mutableAttributedString(withStyle style: TextStyle) -> NSMutableAttributedString {
        NSMutableAttributedString(string: self, attributes: style.attributes)
    }
}

public extension TextStyle {
    func attributedString(from string: String) -> NSAttributedString {
        NSAttributedString(string: string, attributes: attributes)
    }

    func mutableAttributedString(from string: String) -> NSMutableAttributedString {
        NSMutableAttributedString(string: string, attributes: attributes)
    }
}
