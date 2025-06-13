  set(sources
    "modp_b64.cc"
    "modp_b64.h"
    "modp_b64_data.h"
  )

add_library(modp_b64 STATIC
  ${sources}
)

target_INCLUDE_DIRECTORIES(modp_b64
  PUBLIC
  "${CMAKE_SOURCE_DIR}/OpenFinRVM/OpenFinRVM_utilities_lib/ThirdParty/Chromium"
  "${CMAKE_CURRENT_SOURCE_DIR}/../../../gen"
)
