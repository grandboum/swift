// This file is a part of the multi-file test driven by 'main.swift'.

// NB: No "-verify"--this file should parse successfully on its own.
// RUN: %target-swift-frontend(mock-sdk: %clang-importer-sdk) -typecheck -parse-as-library %s

// REQUIRES: objc_interop

import UIKit

@UIApplicationMain // expected-error{{'UIApplicationMain' attribute cannot be used in a module that contains top-level code}}
// expected-deprecated-warning@-1 {{'UIApplicationMain' is deprecated; this is an error in the Swift 6 language mode}}
// expected-deprecated-note@-2 {{use @main instead}} {{1-19=@main}}
class MyDelegate: NSObject, UIApplicationDelegate {
}

func hi() {}
// UNSUPPORTED: OS=windows-msvc
