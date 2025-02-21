// RUN: %target-typecheck-verify-swift

protocol P {
  func invoke()

  associatedtype X
  associatedtype Y where Y : Q
}

protocol Q {
  associatedtype T
}

struct S: Q {
  typealias T = Int
}

extension P where X == () {
  typealias Y = S
}
// UNSUPPORTED: OS=windows-msvc
