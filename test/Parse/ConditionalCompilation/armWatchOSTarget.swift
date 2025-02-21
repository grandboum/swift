// RUN: %swift -typecheck %s -verify -target arm-apple-watchos2.0 -parse-stdlib
// RUN: %swift-ide-test -test-input-complete -source-filename=%s -target arm-apple-watchos2.0

#if os(iOS)
// This block should not parse.
// os(tvOS) or os(watchOS) does not imply os(iOS).
let i: Int = "Hello"
#endif

#if arch(arm) && os(watchOS) && _runtime(_ObjC) && _endian(little) && _pointerBitWidth(_32)
#if _hasAtomicBitWidth(_8) && _hasAtomicBitWidth(_16) && _hasAtomicBitWidth(_32) && _hasAtomicBitWidth(_64)
class C {}
var x = C()
#endif
#endif
var y = x
// UNSUPPORTED: OS=windows-msvc
