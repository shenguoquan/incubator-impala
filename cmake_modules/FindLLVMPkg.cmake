# Usage of this module as follows:
#
#  find_package(LLVMPkg)
#
# Find the native LLVM package

if (DEFINED ENV{HOMEBREW_PREFIX})
  set(HOMEBREW_PREFIX "$ENV{HOMEBREW_PREFIX}")
else()
  set(HOMEBREW_PREFIX "/usr/local")
endif()

# First look in LLVM_ROOT then ENV{LLVM_HOME}, ${HOMEBREW_PREFIX}, system path.
find_program(LLVM_CONFIG_EXECUTABLE 
  llvm-config
  llvm-config-7.0
  llvm-config-6.0
  llvm-config-5.0
  llvm-config-4.0
  PATHS
  $ENV{LLVM_HOME}/bin
  ${HOMEBREW_PREFIX}
  ENV PATH
  NO_DEFAULT_PATH
)

if (LLVM_CONFIG_EXECUTABLE STREQUAL "LLVM_CONFIG_EXECUTABLE-NOTFOUND")
  message(FATAL_ERROR "Could not find llvm-config")
endif ()

execute_process(
  COMMAND ${LLVM_CONFIG_EXECUTABLE} --version
  OUTPUT_VARIABLE LLVM_CONFIG_VERSION
  OUTPUT_STRIP_TRAILING_WHITESPACE
)

if(LLVM_CONFIG_VERSION VERSION_LESS "4.0.0")
    message(FATAL_ERROR "llvm-config version has to be 4.0.0 or beyond")
endif()
message(STATUS "LLVM llvm-config found at: ${LLVM_CONFIG_EXECUTABLE}")

execute_process(
  COMMAND ${LLVM_CONFIG_EXECUTABLE} --cmakedir
  OUTPUT_VARIABLE LLVM_CMAKE_DIR
  OUTPUT_STRIP_TRAILING_WHITESPACE
)
