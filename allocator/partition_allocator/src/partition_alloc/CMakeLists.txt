cmake_minimum_required(VERSION 3.19)

if(APPLE)
set(POSIX 1)
else()
set(POSIX 0)
endif(APPLE)

set(LINUX 0)

  set(raw_ptr_public
    "pointers/instance_tracer.h"
    "pointers/raw_ptr.h"
    "pointers/raw_ptr_cast.h"
    "pointers/raw_ptr_exclusion.h"
    "pointers/raw_ptr_noop_impl.h"
    "pointers/raw_ref.h"
  )
  set(raw_ptr_sources
    "pointers/instance_tracer.cc"
  )
  #public_configs = [ ":public_includes" ]
  #configs += [ "//build/config/compiler:wexit_time_destructors" ]

  #if (enable_backup_ref_ptr_support) {
    #sources += [
      #"pointers/raw_ptr_backup_ref_impl.cc"
      #"pointers/raw_ptr_backup_ref_impl.h"
    #]
  #} else if (use_hookable_raw_ptr) {
    #sources += [
      #"pointers/raw_ptr_hookable_impl.cc"
      #"pointers/raw_ptr_hookable_impl.h"
    #]
  #} else if (use_asan_unowned_ptr) {
    #sources += [
      #"pointers/raw_ptr_asan_unowned_impl.cc"
      #"pointers/raw_ptr_asan_unowned_impl.h"
    #]
  #} else {
    list(APPEND raw_ptr_sources "pointers/raw_ptr_noop_impl.h")
    list(APPEND raw_ptr_sources "pointers/empty.cc")
  #}
  #if (use_partition_alloc) {
    #public_deps = [ ":partition_alloc" ]
  #}
  #deps = [ ":buildflags" ]

  # See also: `partition_alloc_base/component_export.h`
  set(raw_ptr__defines "IS_RAW_PTR_IMPL")

  #configs -= _remove_configs
  #configs += _add_configs
  #configs += [ ":dependants_extra_warnings" ]

message("@@RVM_BUILD_WIN_IS_64BIT...............: ${RVM_BUILD_WIN_IS_64BIT}")
message("@@CMAKE_SYSTEM_PROCESSOR...............: ${CMAKE_SYSTEM_PROCESSOR}")
message("@@CMAKE_C_COMPILER_TARGET...............: ${CMAKE_C_COMPILER_TARGET}")
message("@@CMAKE_CXX_COMPILER_TARGET...............: ${CMAKE_CXX_COMPILER_TARGET}")
message("@@CMAKE_CXX_FLAGS...............: ${CMAKE_CXX_FLAGS}")
message("@@CMAKE_EXE_LINKER_FLAGS...............: ${CMAKE_EXE_LINKER_FLAGS}")
message("@@CMAKE_STATIC_LINKER_FLAGS...............: ${CMAKE_STATIC_LINKER_FLAGS}")

# build/config/win:runtime_library:
list(APPEND raw_ptr_defines
  "__STD_C"
  "_CRT_RAND_S"
  "_CRT_SECURE_NO_DEPRECATE"
  "_SCL_SECURE_NO_DEPRECATE"
  "_ATL_NO_OPENGL"
  "_WINDOWS"
  "CERT_CHAIN_PARA_HAS_EXTRA_FIELDS"
  "PSAPI_VERSION=2"
  "WIN32"
  "_SECURE_ATL"
  "WINAPI_FAMILY=WINAPI_FAMILY_DESKTOP_APP"
)

# build/config/win:winver:
#list(APPEND raw_ptr_defines
  #"NTDDI_VERSION=NTDDI_WIN10_NI"
  #"_WIN32_WINNT=0x0A00"
  #"WINVER=0x0A00"
#)

add_library(partition_allocator_raw_ptr STATIC "")

target_sources(partition_allocator_raw_ptr PRIVATE ${raw_ptr_sources} PUBLIC ${raw_ptr_public})

target_INCLUDE_DIRECTORIES(partition_allocator_raw_ptr
  PUBLIC
  "${CMAKE_SOURCE_DIR}/OpenFinRVM/OpenFinRVM_utilities_lib/ThirdParty/Chromium"
  "${CMAKE_CURRENT_SOURCE_DIR}/.."
  "${CMAKE_SOURCE_DIR}/OpenFinRVM/OpenFinRVM_utilities_lib/ThirdParty/Chromium/gen/base/allocator/partition_allocator/src"
)

target_compile_definitions(partition_allocator_raw_ptr PUBLIC ${raw_ptr_defines})

rvm_add_TARGET_compile_option("partition_allocator_raw_ptr" "-Wno-implicit-float-conversion")
rvm_add_TARGET_compile_option("partition_allocator_raw_ptr" "-Wno-float-conversion")


    set(allocator_core_sources
      "address_pool_manager.cc"
      "address_pool_manager.h"
      "address_pool_manager_bitmap.cc"
      "address_pool_manager_bitmap.h"
      "address_pool_manager_types.h"
      "address_space_randomization.cc"
      "address_space_randomization.h"
      "address_space_stats.h"
      "allocation_guard.cc"
      "allocation_guard.h"
      "compressed_pointer.cc"
      "compressed_pointer.h"
      "dangling_raw_ptr_checks.cc"
      "dangling_raw_ptr_checks.h"
      "flags.h"
      "freeslot_bitmap.h"
      "freeslot_bitmap_constants.h"
      "gwp_asan_support.cc"
      "gwp_asan_support.h"
      "in_slot_metadata.h"
      "internal_allocator.cc"
      "internal_allocator.h"
      "internal_allocator_forward.h"
      "lightweight_quarantine.cc"
      "lightweight_quarantine.h"
      "memory_reclaimer.cc"
      "memory_reclaimer.h"
      "oom.cc"
      "oom.h"
      "oom_callback.cc"
      "oom_callback.h"
      "page_allocator.cc"
      "page_allocator.h"
      "page_allocator_constants.h"
      "page_allocator_internal.h"
      "partition_address_space.cc"
      "partition_address_space.h"
      "partition_alloc-inl.h"
      "partition_alloc.cc"
      "partition_alloc.h"
      "partition_alloc_allocation_data.h"
      "partition_alloc_check.h"
      "partition_alloc_config.h"
      "partition_alloc_constants.h"
      "partition_alloc_forward.h"
      "partition_alloc_hooks.cc"
      "partition_alloc_hooks.h"
      "partition_bucket.cc"
      "partition_bucket.h"
      "partition_bucket_lookup.h"
      "partition_cookie.h"
      "partition_dcheck_helper.cc"
      "partition_dcheck_helper.h"
      "partition_direct_map_extent.h"
      "partition_freelist_entry.cc"
      "partition_freelist_entry.h"
      "partition_lock.h"
      "partition_oom.cc"
      "partition_oom.h"
      "partition_page.cc"
      "partition_page.h"
      "partition_page_constants.h"
      "partition_root.cc"
      "partition_root.h"
      "partition_stats.cc"
      "partition_stats.h"
      "partition_superpage_extent_entry.h"
      "partition_tls.h"
      "random.cc"
      "random.h"
      "reservation_offset_table.cc"
      "reservation_offset_table.h"
      "reverse_bytes.h"
      "spinning_mutex.cc"
      "spinning_mutex.h"
      "tagging.cc"
      "tagging.h"
      "thread_cache.cc"
      "thread_cache.h"
      "thread_isolation/alignment.h"
      "thread_isolation/pkey.cc"
      "thread_isolation/pkey.h"
      "thread_isolation/thread_isolation.cc"
      "thread_isolation/thread_isolation.h"
      "yield_processor.h"
    )

    if(0)
      list(APPEND allocator_core_sources
        "starscan/logging.h"
        "starscan/pcscan.cc"
        "starscan/pcscan.h"
        "starscan/pcscan_internal.cc"
        "starscan/pcscan_internal.h"
        "starscan/pcscan_scheduling.cc"
        "starscan/pcscan_scheduling.h"
        "starscan/raceful_worklist.h"
        "starscan/scan_loop.h"
        "starscan/snapshot.cc"
        "starscan/snapshot.h"
        "starscan/stack/stack.cc"
        "starscan/stack/stack.h"
        "starscan/starscan_fwd.h"
        "starscan/state_bitmap.h"
        "starscan/stats_collector.cc"
        "starscan/stats_collector.h"
        "starscan/stats_reporter.h"
        "starscan/write_protector.cc"
        "starscan/write_protector.h"
      )
    endif(0)

    set(allocator_core_defines "")
    if(WIN32)
      list(APPEND allocator_core_sources
        "page_allocator_internals_win.h"
        "partition_tls_win.cc"
      )
    elseif(POSIX)
      list(APPEND allocator_core_sources
        "page_allocator_internals_posix.cc"
        "page_allocator_internals_posix.h"
      )
    #} else if (is_fuchsia) {
      #sources += [ "page_allocator_internals_fuchsia.h" ]
    endif(WIN32)
    #if (is_android) {
      # The Android NDK supports PR_MTE_* macros as of NDK r23.
      #defines += [ "HAS_PR_MTE_MACROS" ]
    #}
    #if (use_starscan) {
      #if (current_cpu == "x64") {
        #assert(pcscan_stack_supported)
        #sources += [ "starscan/stack/asm/x64/push_registers_asm.cc" ]
      #} else if (current_cpu == "x86") {
        #assert(pcscan_stack_supported)
        #sources += [ "starscan/stack/asm/x86/push_registers_asm.cc" ]
      #} else if (current_cpu == "arm") {
        #assert(pcscan_stack_supported)
        #sources += [ "starscan/stack/asm/arm/push_registers_asm.cc" ]
      #} else if (current_cpu == "arm64") {
        #assert(pcscan_stack_supported)
        #sources += [ "starscan/stack/asm/arm64/push_registers_asm.cc" ]
      #} else if (current_cpu == "riscv64") {
        #assert(pcscan_stack_supported)
        #sources += [ "starscan/stack/asm/riscv64/push_registers_asm.cc" ]
      #} else {
        # To support a trampoline for another arch, please refer to v8/src/heap/base.
        #assert(!pcscan_stack_supported)
      #}
    #}
    #if (use_freelist_pool_offsets) {
    if(0)
      list(APPEND allocator_core_sources "pool_offset_freelist.h")
    else()
      list(APPEND allocator_core_sources "encoded_next_freelist.h")
    endif(0)

    #public_deps = [
      #":chromecast_buildflags",
      #":chromeos_buildflags",
      #":debugging_buildflags",
      #":partition_alloc_buildflags",
    #]

    #configs += [
      #":partition_alloc_implementation",
      list(APPEND allocator_core_defines "IS_PARTITION_ALLOC_IMPL")
      #":memory_tagging",
      #"//build/config/compiler:wexit_time_destructors",
    #]
    #deps = [ ":allocator_base" ]
    #public_configs = []
    #if (is_android) {
      # tagging.cc requires __arm_mte_set_* functions.
      #deps += [ "//third_party/cpu_features:ndk_compat" ]
    #}
    #if (is_fuchsia) {
      #deps += [
        #"//third_party/fuchsia-sdk/sdk/fidl/fuchsia.kernel:fuchsia.kernel_cpp",
        #"//third_party/fuchsia-sdk/sdk/pkg/component_incoming_cpp",
      #]
      #public_deps += [
        #"//third_party/fuchsia-sdk/sdk/pkg/sync",
        #"//third_party/fuchsia-sdk/sdk/pkg/zx",
      #]

      # Needed for users of spinning_mutex.h, which for performance reasons,
      # contains inlined calls to `libsync` inside the header file.
      # It appends an entry to the "libs" section of the dependent target.
      #public_configs += [ ":fuchsia_sync_lib" ]
    #}

    set(allocator_core_frameworks "")
    if(APPLE)
      # SecTaskGetCodeSignStatus needs:
      list(APPEND allocator_core_frameworks "Security.framework")
    endif(APPLE)

    if(APPLE)
      list(APPEND allocator_core_frameworks
        "CoreFoundation.framework"
        "Foundation.framework"
      )
    endif(APPLE)

    #configs -= _remove_configs
    #configs += _add_configs
    #configs += [ ":dependants_extra_warnings" ]

    # We want to be able to test pkey mode without access to the default pkey.
    # This is incompatible with stack protectors since the TLS won't be pkey-tagged.
    #if (enable_pkeys && is_debug) {
      #configs += [ ":no_stack_protector" ]
    #}

# build/config/win:runtime_library:
list(APPEND allocator_core_defines
  "__STD_C"
  "_CRT_RAND_S"
  "_CRT_SECURE_NO_DEPRECATE"
  "_SCL_SECURE_NO_DEPRECATE"
  "_ATL_NO_OPENGL"
  "_WINDOWS"
  "CERT_CHAIN_PARA_HAS_EXTRA_FIELDS"
  "PSAPI_VERSION=2"
  "WIN32"
  "_SECURE_ATL"
  "WINAPI_FAMILY=WINAPI_FAMILY_DESKTOP_APP"
)

# build/config/win:winver:
#list(APPEND allocator_core_defines
  #"NTDDI_VERSION=NTDDI_WIN10_NI"
  #"_WIN32_WINNT=0x0A00"
  #"WINVER=0x0A00"
#)

add_library(allocator_core STATIC "")

target_sources(allocator_core PRIVATE ${allocator_core_sources})

target_INCLUDE_DIRECTORIES(allocator_core
  PUBLIC
  "${CMAKE_SOURCE_DIR}/OpenFinRVM/OpenFinRVM_utilities_lib/ThirdParty/Chromium"
  "${CMAKE_CURRENT_SOURCE_DIR}/.."
  "${CMAKE_SOURCE_DIR}/OpenFinRVM/OpenFinRVM_utilities_lib/ThirdParty/Chromium/gen/base/allocator/partition_allocator/src"
)

target_compile_definitions(allocator_core
  PUBLIC
  ${allocator_core_defines}
  #PRIVATE
  #_WIN32_WINNT=0x0603
)

if(APPLE)
  target_link_libraries(allocator_core PRIVATE
    ${allocator_core_frameworks}
  )
endif(APPLE)

target_link_libraries(allocator_core
  PRIVATE
  allocator_base
)

rvm_add_TARGET_compile_option("allocator_core" "-Wno-implicit-float-conversion")
rvm_add_TARGET_compile_option("allocator_core" "-Wno-float-conversion")


    set(allocator_base_sources
      "partition_alloc_base/atomic_ref_count.h"
      "partition_alloc_base/augmentations/compiler_specific.h"
      "partition_alloc_base/bit_cast.h"
      "partition_alloc_base/bits.h"
      "partition_alloc_base/check.cc"
      "partition_alloc_base/check.h"
      "partition_alloc_base/compiler_specific.h"
      "partition_alloc_base/component_export.h"
      "partition_alloc_base/cpu.cc"
      "partition_alloc_base/cpu.h"
      "partition_alloc_base/cxx20_is_constant_evaluated.h"
      "partition_alloc_base/debug/alias.cc"
      "partition_alloc_base/debug/alias.h"
      "partition_alloc_base/debug/stack_trace.cc"
      "partition_alloc_base/debug/stack_trace.h"
      "partition_alloc_base/export_template.h"
      "partition_alloc_base/immediate_crash.h"
      "partition_alloc_base/log_message.cc"
      "partition_alloc_base/log_message.h"
      "partition_alloc_base/logging.cc"
      "partition_alloc_base/logging.h"
      "partition_alloc_base/memory/page_size.h"
      "partition_alloc_base/memory/ref_counted.cc"
      "partition_alloc_base/memory/ref_counted.h"
      "partition_alloc_base/memory/scoped_policy.h"
      "partition_alloc_base/memory/scoped_refptr.h"
      "partition_alloc_base/no_destructor.h"
      "partition_alloc_base/notreached.h"
      "partition_alloc_base/numerics/checked_math.h"
      "partition_alloc_base/numerics/checked_math_impl.h"
      "partition_alloc_base/numerics/clamped_math.h"
      "partition_alloc_base/numerics/clamped_math_impl.h"
      "partition_alloc_base/numerics/safe_conversions.h"
      "partition_alloc_base/numerics/safe_conversions_arm_impl.h"
      "partition_alloc_base/numerics/safe_conversions_impl.h"
      "partition_alloc_base/numerics/safe_math.h"
      "partition_alloc_base/numerics/safe_math_arm_impl.h"
      "partition_alloc_base/numerics/safe_math_clang_gcc_impl.h"
      "partition_alloc_base/numerics/safe_math_shared_impl.h"
      "partition_alloc_base/posix/eintr_wrapper.h"
      "partition_alloc_base/process/process_handle.h"
      "partition_alloc_base/rand_util.cc"
      "partition_alloc_base/rand_util.h"
      "partition_alloc_base/scoped_clear_last_error.h"
      "partition_alloc_base/strings/cstring_builder.cc"
      "partition_alloc_base/strings/cstring_builder.h"
      "partition_alloc_base/strings/safe_sprintf.cc"
      "partition_alloc_base/strings/safe_sprintf.h"
      "partition_alloc_base/strings/string_util.cc"
      "partition_alloc_base/strings/string_util.h"
      "partition_alloc_base/strings/stringprintf.cc"
      "partition_alloc_base/strings/stringprintf.h"
      "partition_alloc_base/system/sys_info.h"
      "partition_alloc_base/thread_annotations.h"
      "partition_alloc_base/threading/platform_thread.cc"
      "partition_alloc_base/threading/platform_thread.h"
      "partition_alloc_base/threading/platform_thread_ref.h"
      "partition_alloc_base/time/time.cc"
      "partition_alloc_base/time/time.h"
      "partition_alloc_base/time/time_override.cc"
      "partition_alloc_base/time/time_override.h"
      "partition_alloc_base/types/strong_alias.h"
      "partition_alloc_base/win/win_handle_types.h"
      "partition_alloc_base/win/win_handle_types_list.inc"
      "partition_alloc_base/win/windows_types.h"
    )

    set(allocator_base_defines "")

    if(WIN32)
      list(APPEND allocator_base_sources
        "partition_alloc_base/debug/stack_trace_win.cc"
        "partition_alloc_base/memory/page_size_win.cc"
        "partition_alloc_base/process/process_handle_win.cc"
        "partition_alloc_base/rand_util_win.cc"
        "partition_alloc_base/scoped_clear_last_error_win.cc"
        "partition_alloc_base/threading/platform_thread_win.cc"
        "partition_alloc_base/time/time_win.cc"
      )
    elseif(POSIX)
      list(APPEND allocator_base_sources
        "partition_alloc_base/debug/stack_trace_posix.cc"
        "partition_alloc_base/files/file_util.h"
        "partition_alloc_base/files/file_util_posix.cc"
        "partition_alloc_base/memory/page_size_posix.cc"
        "partition_alloc_base/posix/safe_strerror.cc"
        "partition_alloc_base/posix/safe_strerror.h"
        "partition_alloc_base/process/process_handle_posix.cc"
        "partition_alloc_base/rand_util_posix.cc"
        "partition_alloc_base/threading/platform_thread_internal_posix.h"
        "partition_alloc_base/threading/platform_thread_posix.cc"
        "partition_alloc_base/time/time_conversion_posix.cc"
      )

      #if (is_linux || is_chromeos) {
      if(LINUX)
        list(APPEND allocator_base_sources "partition_alloc_base/debug/stack_trace_linux.cc")
      endif(LINUX)

      #if (is_android || is_chromeos_ash) {
        #sources += [ "partition_alloc_base/time/time_android.cc" ]
      #}
      if(APPLE)
        # Request <dlfcn.h> to provide the `dladdr()` function. This is used to
        # translate address to symbolic information.
        list(APPEND allocator_base_defines "HAVE_DLADDR")

        list(APPEND allocator_base_sources
          "partition_alloc_base/debug/stack_trace_mac.cc"
          "partition_alloc_base/time/time_apple.mm"
        )
      else()
        list(APPEND allocator_base_sources "partition_alloc_base/time/time_now_posix.cc")
      endif(APPLE)
    #} else if (is_fuchsia) {
      #sources += [
        #"partition_alloc_base/fuchsia/fuchsia_logging.cc"
        #"partition_alloc_base/fuchsia/fuchsia_logging.h"
        #"partition_alloc_base/memory/page_size_posix.cc"
        #"partition_alloc_base/posix/safe_strerror.cc"
        #"partition_alloc_base/posix/safe_strerror.h"
        #"partition_alloc_base/rand_util_fuchsia.cc"
        #"partition_alloc_base/threading/platform_thread_internal_posix.h"
        #"partition_alloc_base/threading/platform_thread_posix.cc"
        #"partition_alloc_base/time/time_conversion_posix.cc"
        #"partition_alloc_base/time/time_fuchsia.cc"
      #]
    endif(WIN32)
    #if (is_android) {
      # Only android build requires native_library, and native_library depends
      # on file_path. So file_path is added if is_android = true.
      #sources += [
        #"partition_alloc_base/debug/stack_trace_android.cc"
        #"partition_alloc_base/files/file_path.cc"
        #"partition_alloc_base/files/file_path.h"
        #"partition_alloc_base/native_library.cc"
        #"partition_alloc_base/native_library.h"
        #"partition_alloc_base/native_library_posix.cc"
      #]
    #}
    if(APPLE)
      # Apple-specific utilities
      list(APPEND allocator_base_sources
        "partition_alloc_base/apple/foundation_util.h"
        "partition_alloc_base/apple/foundation_util.mm"
        "partition_alloc_base/apple/mach_logging.cc"
        "partition_alloc_base/apple/mach_logging.h"
        "partition_alloc_base/apple/scoped_cftyperef.h"
        "partition_alloc_base/apple/scoped_typeref.h"
      )
      #if (is_ios) {
        #sources += [
          #"partition_alloc_base/ios/ios_util.h"
          #"partition_alloc_base/ios/ios_util.mm"
          #"partition_alloc_base/system/sys_info_ios.mm"
        #]
      #}
      #if (is_mac) {
        list(APPEND allocator_base_sources
          "partition_alloc_base/mac/mac_util.h"
          "partition_alloc_base/mac/mac_util.mm"
          "partition_alloc_base/system/sys_info_mac.mm"
        )
      #}
    endif(APPLE)

    #public_deps = [
      #":chromecast_buildflags",
      #":chromeos_buildflags",
      #":debugging_buildflags",
      #":partition_alloc_buildflags",
    #]
    #public_configs = [ ":public_includes" ]
    #configs += [
      #":partition_alloc_base_implementation",
      #"//build/config/compiler:wexit_time_destructors",
    #]

    #deps = []
    #if (is_fuchsia) {
      #public_deps += [ "//third_party/fuchsia-sdk/sdk/pkg/fit" ]
    #}

    set(allocator_base_frameworks "")
    if(APPLE)
      list(APPEND allocator_base_frameworks
        "CoreFoundation.framework"
        "Foundation.framework"
      )
    endif(APPLE)

    #configs -= _remove_configs
    #configs += _add_configs
    #configs += [ ":dependants_extra_warnings" ]

# build/config/win:runtime_library:
list(APPEND allocator_base_defines
  "__STD_C"
  "_CRT_RAND_S"
  "_CRT_SECURE_NO_DEPRECATE"
  "_SCL_SECURE_NO_DEPRECATE"
  "_ATL_NO_OPENGL"
  "_WINDOWS"
  "CERT_CHAIN_PARA_HAS_EXTRA_FIELDS"
  "PSAPI_VERSION=2"
  "WIN32"
  "_SECURE_ATL"
  "WINAPI_FAMILY=WINAPI_FAMILY_DESKTOP_APP"
)

# build/config/win:winver:
#list(APPEND allocator_base_defines
  #"NTDDI_VERSION=NTDDI_WIN10_NI"
  #"_WIN32_WINNT=0x0A00"
  #"WINVER=0x0A00"
#)

add_library(allocator_base STATIC "")

target_sources(allocator_base PRIVATE ${allocator_base_sources})

target_INCLUDE_DIRECTORIES(allocator_base
  PUBLIC
  "${CMAKE_SOURCE_DIR}/OpenFinRVM/OpenFinRVM_utilities_lib/ThirdParty/Chromium"
  "${CMAKE_CURRENT_SOURCE_DIR}/.."
  "${CMAKE_SOURCE_DIR}/OpenFinRVM/OpenFinRVM_utilities_lib/ThirdParty/Chromium/gen/base/allocator/partition_allocator/src"
)

target_compile_definitions(allocator_base PUBLIC ${allocator_base_defines})

if(APPLE)
  target_link_libraries(allocator_base PRIVATE
    ${allocator_base_frameworks}
  )
endif(APPLE)

rvm_add_TARGET_compile_option("allocator_base" "-Wno-implicit-float-conversion")
rvm_add_TARGET_compile_option("allocator_base" "-Wno-float-conversion")


    set(allocator_shim_sources "")
    #deps = []
    #all_dependent_configs = []
    #public_configs = [ ":public_includes" ]
    #configs += [
      #":allocator_shim_implementation",
      #"//build/config/compiler:wexit_time_destructors",
    #]
    set(allocator_shim_frameworks "")

    #configs -= _remove_configs
    #configs += _add_configs
    #configs += [ ":dependants_extra_warnings" ]

    set(shim_headers "")
    set(shim_sources "")

    list(APPEND shim_sources
      "shim/allocator_shim.cc"
      "shim/allocator_shim_dispatch_to_noop_on_free.cc"
    )
    list(APPEND shim_headers
      "shim/allocator_shim.h"
      "shim/allocator_shim_internals.h"
      "shim/shim_alloc_functions.h"
      "shim/allocator_shim_functions.h"
      "shim/allocator_dispatch.h"
      "shim/allocator_shim_dispatch_to_noop_on_free.h"
    )
    #if (use_partition_alloc) {
    if(0)
      list(APPEND shim_sources
        "shim/allocator_shim_default_dispatch_to_partition_alloc.cc"
        "shim/nonscannable_allocator.cc"
      )
      list(APPEND shim_headers
        "shim/allocator_shim_default_dispatch_to_partition_alloc.h"
        "shim/nonscannable_allocator.h"
      )
    endif(0)
    #if (is_android) {
      #shim_headers += [
        #"shim/allocator_shim_override_cpp_symbols.h"
        #"shim/allocator_shim_override_linker_wrapped_symbols.h"
      #]
      #shim_sources -= [ "shim/allocator_shim.cc" ]
      #shim_sources += [ "shim/allocator_shim_android.cc" ]
      #if (use_allocator_shim) {
        #all_dependent_configs += [ ":wrap_malloc_symbols" ]
      #}
    #}
    if(APPLE)
      list(APPEND shim_headers
        "shim/allocator_shim_override_apple_default_zone.h"
        "shim/allocator_shim_override_apple_symbols.h"
        "shim/early_zone_registration_constants.h"
        "shim/allocator_interception_apple.h"
        "shim/malloc_zone_functions_apple.h"
      )
      list(REMOVE_ITEM shim_sources "shim/allocator_shim.cc")
      list(APPEND shim_sources
        "shim/allocator_interception_apple.mm"
        "shim/allocator_shim_apple.cc"
        "shim/malloc_zone_functions_apple.cc"
      )
      list(APPEND allocator_shim_frameworks "CoreFoundation.framework")

      #if (use_allocator_shim) {
        #configs += [ ":mac_no_default_new_delete_symbols" ]

        # Do not compile with ARC because this target has to interface with
        # low-level Objective-C and having ARC would interfere.
        #configs -= [ "//build/config/compiler:enable_arc" ]
      #}
    endif(APPLE)
    #if (is_chromeos || is_linux) {
    if(LINUX)
      list(APPEND shim_headers
        "shim/allocator_shim_override_cpp_symbols.h"
        "shim/allocator_shim_override_glibc_weak_symbols.h"
        "shim/allocator_shim_override_libc_symbols.h"
      )
    endif(LINUX)
    if(WIN32)
      list(APPEND shim_headers
        "shim/allocator_shim_override_ucrt_symbols_win.h"
        "shim/winheap_stubs_win.h"
      )
      list(REMOVE_ITEM shim_sources "shim/allocator_shim.cc")
      list(APPEND shim_sources "shim/winheap_stubs_win.cc")

      #if (!is_component_build) {
      if(1)
        list(APPEND shim_sources
          "shim/allocator_shim_win_static.cc"
          "shim/checked_multiply_win.h"
        )
      else(1)
        list(APPEND shim_sources
          "shim/allocator_shim_functions_win_component.cc"
          "shim/allocator_shim_win_component.cc"
        )

        # allocator_shim cannot depend on libc++ objects because they use malloc()
        # internally.
        #no_default_deps = true
      endif(1)
    endif(WIN32)

    #if (!use_partition_alloc_as_malloc) {
    if(0)
      #if (is_android) {
        #shim_sources += [
          #"shim/allocator_shim_default_dispatch_to_linker_wrapped_symbols.cc"
        #]
      #}
      if(APPLE)
        list(APPEND shim_sources
            "shim/allocator_shim_default_dispatch_to_apple_zoned_malloc.cc")
      endif(APPLE)
      #if (is_chromeos || is_linux) {
        #shim_sources += [ "shim/allocator_shim_default_dispatch_to_glibc.cc" ]
      #}
      if(WIN32)
        list(APPEND shim_sources "shim/allocator_shim_default_dispatch_to_winheap.cc")
      endif(WIN32)
    endif(0)

    set(allocator_shim_sources ${shim_headers})
    #if (use_allocator_shim) {
    if(0)
      list(APPEND allocator_shim_sources ${shim_sources})
    else()
      # To avoid "lld-link: error: <root>: undefined symbol: _DllMainCRTStartup",
      # at least one object file is required when linking allocator_shim.dll.
      list(APPEND allocator_shim_sources "shim/empty.cc")
    endif(0)

    #deps += [
      #":allocator_base",
      #":allocator_core",
      #":buildflags",
    #]

set(allocator_shim_defines "")
# build/config/win:runtime_library:
list(APPEND allocator_shim_defines
  "__STD_C"
  "_CRT_RAND_S"
  "_CRT_SECURE_NO_DEPRECATE"
  "_SCL_SECURE_NO_DEPRECATE"
  "_ATL_NO_OPENGL"
  "_WINDOWS"
  "CERT_CHAIN_PARA_HAS_EXTRA_FIELDS"
  "PSAPI_VERSION=2"
  "WIN32"
  "_SECURE_ATL"
  "WINAPI_FAMILY=WINAPI_FAMILY_DESKTOP_APP"
)

# build/config/win:winver:
#list(APPEND allocator_shim_defines
  #"NTDDI_VERSION=NTDDI_WIN10_NI"
  #"_WIN32_WINNT=0x0A00"
  #"WINVER=0x0A00"
#)

add_library(allocator_shim STATIC "")

target_sources(allocator_shim PRIVATE ${allocator_shim_sources})

target_INCLUDE_DIRECTORIES(allocator_shim
  PUBLIC
  "${CMAKE_SOURCE_DIR}/OpenFinRVM/OpenFinRVM_utilities_lib/ThirdParty/Chromium"
  "${CMAKE_CURRENT_SOURCE_DIR}/.."
  "${CMAKE_SOURCE_DIR}/OpenFinRVM/OpenFinRVM_utilities_lib/ThirdParty/Chromium/gen/base/allocator/partition_allocator/src"
)

target_compile_definitions(partition_allocator_raw_ptr PUBLIC ${allocator_shim_defines})

if(APPLE)
  target_link_libraries(allocator_shim PRIVATE
    ${allocator_shim_frameworks}
  )
endif(APPLE)

target_link_libraries(allocator_shim
  PRIVATE
  allocator_base
  allocator_core
)

rvm_add_TARGET_compile_option("allocator_shim" "-Wno-implicit-float-conversion")
rvm_add_TARGET_compile_option("allocator_shim" "-Wno-float-conversion")
