// RUN: %target-swift-ide-test -print-module -module-to-print=InvalidNestedStruct -I %S/Inputs/ -source-filename=x -enable-experimental-cxx-interop | %FileCheck %s

// CHECK-NOT: CannotImport
// CHECK-NOT: ForwardDeclaredSibling
// UNSUPPORTED: OS=windows-msvc
