// RUN: %target-typecheck-verify-swift -I %S/Inputs -enable-experimental-cxx-interop

import MemberVariables

var s = MyClass()
s.const_member = 42 // expected-error {{cannot assign to property: 'const_member' setter is inaccessible}}
// UNSUPPORTED: OS=windows-msvc
