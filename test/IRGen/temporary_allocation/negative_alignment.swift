// RUN: not %target-swift-frontend -primary-file %s -O -emit-ir -o /dev/null 2>&1 | %FileCheck %s

@_silgen_name("blackHole")
func blackHole(_ value: UnsafeMutableRawPointer?) -> Void

withUnsafeTemporaryAllocation(byteCount: 1, alignment: -1) { buffer in
    blackHole(buffer.baseAddress)
}
// CHECK: error: alignment value must be greater than zero
// UNSUPPORTED: OS=windows-msvc
