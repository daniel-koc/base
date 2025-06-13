  set(sources
    "../no_destructor.h"
    "current_module.h"
    "pe_image.cc"
    "pe_image.h"
  )

add_library(pe_image STATIC
  ${sources}
)

target_INCLUDE_DIRECTORIES(pe_image
  PUBLIC
  "${CMAKE_SOURCE_DIR}/OpenFinRVM/OpenFinRVM_utilities_lib/ThirdParty/Chromium"
  "${CMAKE_CURRENT_SOURCE_DIR}/../../gen"
)
