// REQUIRES: rdar72627583

import ClangFW
import SwiftFW

func foo() {
  /*HERE*/
}

// Checks that, due to default check delay, a modification will be ignored and fast completion will still activate.
// REQUIRES: shell

// RUN: %empty-directory(%t/Frameworks)
// RUN: %empty-directory(%t/MyProject)

// RUN: COMPILER_ARGS=( \
// RUN:   -target %target-triple \
// RUN:   -module-name MyProject \
// RUN:   -F %t/Frameworks \
// RUN:   -I %t/MyProject \
// RUN:   -import-objc-header %t/MyProject/Bridging.h \
// RUN:   %t/MyProject/Library.swift \
// RUN:   %s \
// RUN: )
// RUN: INPUT_DIR=%S/Inputs/checkdeps

// RUN: cp -R $INPUT_DIR/MyProject %t/
// RUN: cp -R $INPUT_DIR/ClangFW.framework %t/Frameworks/
// RUN: touch -t 202001010101 %t/Frameworks/ClangFW.framework/Headers/*
// RUN: %empty-directory(%t/Frameworks/SwiftFW.framework/Modules/SwiftFW.swiftmodule)
// RUN: %target-swift-frontend -emit-module -module-name SwiftFW -o %t/Frameworks/SwiftFW.framework/Modules/SwiftFW.swiftmodule/%target-swiftmodule-name $INPUT_DIR/SwiftFW_src/Funcs.swift

// RUN: %sourcekitd-test \
// RUN:   -req=global-config == \

// RUN:   -shell -- echo "### Initial" == \
// RUN:   -req=complete -pos=5:3 %s -- ${COMPILER_ARGS[@]} == \

// RUN:   -shell -- echo '### Modify framework (c)' == \
// RUN:   -shell -- cp -R $INPUT_DIR/ClangFW.framework_mod/* %t/Frameworks/ClangFW.framework/ == \
// RUN:   -shell -- touch -t 210001010101 %t/Frameworks/ClangFW.framework/Headers/*  == \
// RUN:   -req=complete -pos=5:3 %s -- ${COMPILER_ARGS[@]} == \

// RUN:   -req=global-config -req-opts=completion_check_dependency_interval=0 == \
// RUN:   -shell -- echo '### Checking dependencies' == \
// RUN:   -req=complete -pos=5:3 %s -- ${COMPILER_ARGS[@]} \

// RUN:   | %FileCheck %s


// CHECK-LABEL: ### Initial
// CHECK: key.results: [
// CHECK-DAG: key.description: "clangFWFunc()"
// CHECK-DAG: key.description: "swiftFWFunc()"
// CHECK-DAG: key.description: "localClangFunc()"
// CHECK-DAG: key.description: "localSwiftFunc()"
// CHECK: ]
// CHECK-NOT: key.reusingastcontext: 1

// CHECK-LABEL: ### Modify framework (c)
// CHECK: key.results: [
// CHECK-DAG: key.description: "clangFWFunc()"
// CHECK-DAG: key.description: "swiftFWFunc()"
// CHECK-DAG: key.description: "localClangFunc()"
// CHECK-DAG: key.description: "localSwiftFunc()"
// CHECK: ]
// CHECK: key.reusingastcontext: 1

// CHECK-LABEL: ### Checking dependencies
// CHECK: key.results: [
// CHECK-DAG: key.description: "clangFWFunc_mod()"
// CHECK-DAG: key.description: "swiftFWFunc()"
// CHECK-DAG: key.description: "localClangFunc()"
// CHECK-DAG: key.description: "localSwiftFunc()"
// CHECK: ]
// CHECK-NOT: key.reusingastcontext: 1
// UNSUPPORTED: OS=windows-msvc
