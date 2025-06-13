    set(sources
      "../valgrind/valgrind.h"
      "dynamic_annotations.c"
      "dynamic_annotations.h"
    )

add_library(dynamic_annotations STATIC
  ${sources}
)

target_INCLUDE_DIRECTORIES(dynamic_annotations
  PUBLIC
  "${CMAKE_SOURCE_DIR}/OpenFinRVM/OpenFinRVM_utilities_lib/ThirdParty/Chromium"
  "${CMAKE_SOURCE_DIR}/OpenFinRVM/OpenFinRVM_utilities_lib/ThirdParty/Chromium/gen"
)
