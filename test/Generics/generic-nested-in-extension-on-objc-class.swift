// RUN: %empty-directory(%t)
// RUN: cp %s %t/main.swift
// RUN: %target-build-swift -module-name test %t/main.swift %S/Inputs/generic-nested-in-extension-on-objc-class.swift -o %t/a.out
// RUN: %target-codesign %t/a.out
// RUN: %target-run %t/a.out | %FileCheck %s

// REQUIRES: objc_interop
// REQUIRES: executable_test

import Foundation

// https://github.com/apple/swift/issues/53775
//
// Test the fix for a crash when instantiating the metadata for a generic type
// nested in an extension on an ObjC class in a different file.

extension NSString {
  class _Inner2<T> where T: NSObject {}
}

extension NSArray {
  class Inner1: NSString._Inner1<NSArray> {
    override init() {
      super.init()
      print("Inner1")
    }
  }
  class Inner2: NSString._Inner2<NSArray> {
    override init() {
      super.init()
      print("Inner2")
    }
  }
}

// CHECK: Inner1
_ = NSArray.Inner1()

// CHECK: Inner2
_ = NSArray.Inner2()


// UNSUPPORTED: OS=windows-msvc
