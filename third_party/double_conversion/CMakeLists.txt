  set(sources
    "double-conversion/bignum-dtoa.cc"
    "double-conversion/bignum-dtoa.h"
    "double-conversion/bignum.cc"
    "double-conversion/bignum.h"
    "double-conversion/cached-powers.cc"
    "double-conversion/cached-powers.h"
    "double-conversion/diy-fp.h"
    "double-conversion/double-conversion.h"
    "double-conversion/double-to-string.cc"
    "double-conversion/double-to-string.h"
    "double-conversion/fast-dtoa.cc"
    "double-conversion/fast-dtoa.h"
    "double-conversion/fixed-dtoa.cc"
    "double-conversion/fixed-dtoa.h"
    "double-conversion/ieee.h"
    "double-conversion/string-to-double.cc"
    "double-conversion/string-to-double.h"
    "double-conversion/strtod.cc"
    "double-conversion/strtod.h"
    "double-conversion/utils.h"
  )

    set(cflags
      "-Wno-unused-const-variable"
      "-Wno-unused-function"
    )

add_library(double_conversion STATIC
  ${sources}
)

target_compile_options(double_conversion
  PRIVATE
  ${cflags}
)

target_INCLUDE_DIRECTORIES(
  double_conversion
  PUBLIC
  "${CMAKE_CURRENT_SOURCE_DIR}/double-conversion"
)
