// RUN: %target-typecheck-verify-swift -enable-experimental-feature WarnUnsafe

// Make sure everything compiles without error when unsafe code is allowed.
// RUN: %target-swift-frontend -typecheck -enable-experimental-feature AllowUnsafeAttribute -warnings-as-errors %s

// REQUIRES: swift_feature_AllowUnsafeAttribute
// REQUIRES: swift_feature_WarnUnsafe

// expected-warning@+3{{global function 'test' has an interface that involves unsafe types}}
// expected-note@+2{{add '@unsafe' to indicate that this declaration is unsafe to use}}{{1-1=@unsafe }}
// expected-note@+1{{add '@safe' to indicate that this declaration is memory-safe to use}}{1-1=@safe }}
func test(
  x: OpaquePointer, // expected-note{{reference to unsafe struct 'OpaquePointer'}}
  other: UnsafeMutablePointer<Int> // expected-note{{reference to unsafe generic struct 'UnsafeMutablePointer'}}
) {
  var array = [1, 2, 3]
  // expected-warning@+2{{expression uses unsafe constructs but is not marked with 'unsafe'}}{{3-3=unsafe }}
  // expected-note@+1{{reference to instance method 'withUnsafeBufferPointer' involves unsafe type 'UnsafeBufferPointer<Int>'}}
  array.withUnsafeBufferPointer{ buffer in
  // expected-warning@+1{{expression uses unsafe constructs but is not marked with 'unsafe'}}{{5-5=unsafe }}
    print(buffer) // expected-note{{reference to parameter 'buffer' involves unsafe type 'UnsafeBufferPointer<Int>'}}
  }
  array.append(4)
  _ = array
}
