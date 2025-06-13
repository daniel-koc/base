set(prevent_unsafe_narrowing_cflags "")
  #if (is_clang) {
    list(APPEND prevent_unsafe_narrowing_cflags
      "-Wshorten-64-to-32"
      "-Wimplicit-int-conversion"
      "-Wsign-compare"
      "-Wsign-conversion"
    )
    #if (!is_nacl) {
      list(APPEND prevent_unsafe_narrowing_cflags
        # Avoid bugs of the form `if (size_t i = size; i >= 0; --i)` while
        # fixing types to be sign-correct.
        "-Wtautological-unsigned-zero-compare"
      )
    #}
  #}

set(wexit_time_destructors_cflags "")
  #if (is_clang) {
    list(APPEND wexit_time_destructors_cflags
      "-Wexit-time-destructors"
    )
  #}

set(wglobal_constructors_cflags "")
  #if (is_clang) {
    list(APPEND wglobal_constructors_cflags
      "-Wglobal-constructors"
    )
  #}

set(base_win_linker_ldflags "")
list(APPEND base_win_linker_ldflags
  # Linking with shcore.lib causes the shcore api forwarder dll to load.
  "/DELAYLOAD:api-ms-win-shcore-scaling-l1-1-1.dll"
  # Linking with OneCore.lib causes the next three dlls to load.
  "/DELAYLOAD:api-ms-win-core-realtime-l1-1-1.dll"
  "/DELAYLOAD:api-ms-win-power-base-l1-1-0.dll"
  "/DELAYLOAD:api-ms-win-power-setting-l1-1-0.dll"
  "/DELAYLOAD:cfgmgr32.dll"
  "/DELAYLOAD:powrprof.dll"
  "/DELAYLOAD:setupapi.dll"
  "/DELAYLOAD:shcore.dll"
)
