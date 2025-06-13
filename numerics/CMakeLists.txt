# This is a dependency-free, header-only, library, and it needs to stay that
# way to facilitate pulling it into various third-party projects. So, this
# file is here to protect against accidentally introducing external
# dependencies or depending on internal implementation details.

cmake_minimum_required(VERSION 3.19)

set(SRC_DIR "${CMAKE_SOURCE_DIR}/OpenFinRVM/OpenFinRVM_utilities_lib/ThirdParty/Chromium/base/numerics")

  set(sources
    "basic_ops_impl.h"
    "checked_math_impl.h"
    "clamped_math_impl.h"
    "safe_conversions_arm_impl.h"
    "safe_conversions_impl.h"
    "safe_math_arm_impl.h"
    "safe_math_clang_gcc_impl.h"
    "safe_math_shared_impl.h"
  )
  set(public_sources
    "angle_conversions.h"
    "byte_conversions.h"
    "checked_math.h"
    "clamped_math.h"
    "math_constants.h"
    "ostream_operators.h"
    "ranges.h"
    "safe_conversions.h"
    "safe_math.h"
    "wrapping_math.h"
  )

add_library(base_numerics INTERFACE)

target_sources(base_numerics PRIVATE ${sources} PUBLIC ${public_sources})

target_INCLUDE_DIRECTORIES(base_numerics
  INTERFACE
  "${CMAKE_SOURCE_DIR}/OpenFinRVM/OpenFinRVM_utilities_lib/ThirdParty/Chromium"
  "${CMAKE_SOURCE_DIR}/OpenFinRVM/OpenFinRVM_utilities_lib/ThirdParty/Chromium/gen"
)
