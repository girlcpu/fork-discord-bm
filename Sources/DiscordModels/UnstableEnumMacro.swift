
#if swift(>=5.9) && $Macros
/// A to stabilize enums that might get more cases, to some extent.
/// The main goal is to not fail json decodings if Discord adds a new case.
///
/// This is supposed to be used with enums that are supposed to be raw-representable.
/// The macro accepts one and only one of these types as a generic argument:
/// `String`, `Int`, `UInt`. More types can be added on demand.
/// The generic argument represents the `RawValue` of a `RawRepresentable` type.
///
/// How it manipulates the code:
/// Adds a new `.unknown(<Type>)` case where Type is the generic argument of the macro.
/// Adds `RawRepresentable` conformance where `RawValue` is the generic argument of the macro.
/// If `Decodable`, adds a slightly-modified `init(from:)` initializer.
/// If `CaseIterable`, repairs the `static var allCases` requirement.
@attached(member, names: named(init), named(rawValue), named(unknown), named(allCases))
@attached(conformance)
macro UnstableEnum() = #externalMacro(module: "UnstableEnumMacro", type: "UnstableEnumMacro")
#endif
