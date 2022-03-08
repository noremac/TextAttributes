#if canImport(UIKit)
import UIKit
public typealias TextAttributesFont = UIFont
public typealias TextAttributesColor = UIColor
#elseif canImport(AppKit)
import AppKit
public typealias TextAttributesFont = NSFont
public typealias TextAttributesColor = NSColor
#else
#error("unsupported platform")
#endif

@dynamicMemberLookup
public struct TextAttributes {
    @usableFromInline
    static let defaultParagraphStyle = NSMutableParagraphStyle()

    @usableFromInline
    var _paragraphStyle🐮: CowHelper<NSMutableParagraphStyle>!

    @usableFromInline
    var _attributes: [NSAttributedString.Key: Any] = [:]

    // MARK: Initializers

    public init() {}

    public init(_ builder: (inout TextAttributes) -> Void) {
        builder(&self)
    }
}

// MARK: Equatable

extension TextAttributes: Equatable {
    public static func == (lhs: TextAttributes, rhs: TextAttributes) -> Bool {
        (lhs.attributes as NSDictionary).isEqual(to: rhs.attributes)
    }
}

public extension TextAttributes {
    // MARK: Attributes

    /// Set the given attribute for the given key.
    /// - Parameters:
    ///   - attribute: The attribute.
    ///   - key: The key.
    /// - Note: Prefer the type safe properties. Only use this for instances
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
            return paragraphStyle
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
            var attributes = _attributes
            attributes[.paragraphStyle] = style.copy()
            return attributes
        } else {
            return _attributes
        }
    }

    // MARK: Font

    @inlinable
    var font: TextAttributesFont? {
        get { self[.font] }
        set { self[.font] = newValue }
    }

    // MARK: Foreground color

    @inlinable
    var foregroundColor: TextAttributesColor? {
        get { self[.foregroundColor] }
        set { self[.foregroundColor] = newValue }
    }

    // MARK: Background color

    @inlinable
    var backgroundColor: TextAttributesColor? {
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
    var strikethroughColor: TextAttributesColor? {
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
    var underlineColor: TextAttributesColor? {
        get { self[.underlineColor] }
        set { self[.underlineColor] = newValue }
    }

    // MARK: Stroke color

    @inlinable
    var strokeColor: TextAttributesColor? {
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
    /// - Note: Prefer to use the specific properties on ``TextAttributes`` for
    /// manipulating the paragraph style attributes; this property will override
    /// those values.
    @inlinable
    var paragraphStyle: NSParagraphStyle? {
        get {
            // Defensively copy out the value.
            _paragraphStyle🐮?.value.copy() as? NSParagraphStyle
        }
        set {
            if let value = newValue {
                // Defensively copy in the new value.
                _paragraphStyle🐮 = CowHelper(value.mutableCopy() as! NSMutableParagraphStyle)
            } else {
                _paragraphStyle🐮 = nil
            }
        }
    }

    @inlinable
    subscript<T>(dynamicMember keyPath: WritableKeyPath<NSMutableParagraphStyle, T>) -> T {
        get {
            (_paragraphStyle🐮?.value ?? Self.defaultParagraphStyle)[keyPath: keyPath]
        }
        set {
            if _paragraphStyle🐮 == nil {
                // It's not been set yet, create it.
                _paragraphStyle🐮 = CowHelper(NSMutableParagraphStyle())
            } else if !isKnownUniquelyReferenced(&_paragraphStyle🐮) {
                // It's been set, but is shared with another style, so
                // create a mutable copy to help keep COW semantics.
                _paragraphStyle🐮 = _paragraphStyle🐮.mutableCopy()
            }
            // else: it's been set but is not shared with another style so we
            // don't need to do anything and can just modify it in place.
            _paragraphStyle🐮.value[keyPath: keyPath] = newValue
        }
    }
}

// MARK: String

public extension String {
    func attributedString(withStyle style: TextAttributes) -> NSAttributedString {
        NSAttributedString(string: self, attributes: style.attributes)
    }

    func mutableAttributedString(withStyle style: TextAttributes) -> NSMutableAttributedString {
        NSMutableAttributedString(string: self, attributes: style.attributes)
    }
}

public extension TextAttributes {
    func attributedString(from string: String) -> NSAttributedString {
        NSAttributedString(string: string, attributes: attributes)
    }

    func mutableAttributedString(from string: String) -> NSMutableAttributedString {
        NSMutableAttributedString(string: string, attributes: attributes)
    }
}
