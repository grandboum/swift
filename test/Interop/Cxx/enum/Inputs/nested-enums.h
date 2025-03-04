#ifndef TEST_INTEROP_CXX_ENUM_INPUTS_NESTED_ENUMS_H
#define TEST_INTEROP_CXX_ENUM_INPUTS_NESTED_ENUMS_H

namespace ns {

enum EnumInNS {
  kA = 0,
  kB
};

enum class ScopedEnumInNS {
  scopeA,
  scopeB
};

namespace nestedNS {

enum EnumInNestedNS {
  kNestedA = 0,
  kNestedB
};

}

}

namespace HdCamera {
namespace P {
enum Projection { Perspective = 0, Orthographic };
}
} // namespace HdCamera

namespace GfCamera {
namespace P {
enum Projection { Perspective = 0, Orthographic };
}
} // namespace GfCamera

// class HdCamera {
// public:
//   enum Projection { Perspective = 0, Orthographic };
// };

// class GfCamera {
// public:
//   enum Projection { Perspective = 0, Orthographic };
// };

#endif // TEST_INTEROP_CXX_ENUM_INPUTS_NESTED_ENUMS_H
