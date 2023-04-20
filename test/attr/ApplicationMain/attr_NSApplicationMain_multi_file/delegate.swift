// This file is a part of the multi-file test driven by 'another_delegate.swift'.

// NB: No "-verify"--this file should parse successfully on its own.
// RUN: %target-swift-frontend(mock-sdk: %clang-importer-sdk) -typecheck -parse-as-library %s

// REQUIRES: objc_interop

import AppKit

@NSApplicationMain // expected-error{{'NSApplicationMain' attribute can only apply to one class in a module}}
// expected-warning@-1 {{'NSApplicationMain' is deprecated; this is an error in Swift 6}}
// expected-note@-2 {{use @main instead}} {{1-19=@main}}
class MyDelegate: NSObject, NSApplicationDelegate {
}

func hi() {}
