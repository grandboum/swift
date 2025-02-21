// RUN: %swiftc_driver -driver-print-jobs -index-file -index-file-path %s %S/Inputs/SwiftModuleA.swift %s -o %t.output_for_index -index-store-path %t.index_store -module-name driver_index 2>&1 | %FileCheck %s
// CHECK: {{.*}}swift{{(c|c-legacy-driver|-frontend)?(\.exe)?"?}} -frontend -typecheck {{.*}}SwiftModuleA.swift{{"?}} -primary-file {{.*}}driver-index.swift{{"?}} {{.*}}-o {{.*}}.output_for_index{{"?}} {{.*}}-disable-typo-correction {{.*}}-index-store-path {{.*}}.index_store{{"?}} -index-system-modules
// UNSUPPORTED: OS=windows-msvc
