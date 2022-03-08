import Foundation

@usableFromInline
final class CowHelper<Value> {
    @usableFromInline var value: Value

    @usableFromInline
    init(_ value: Value) {
        self.value = value
    }
}

extension CowHelper where Value: NSMutableCopying {
    @inlinable
    func mutableCopy() -> Self {
        .init(value.mutableCopy(with: nil) as! Value)
    }
}
