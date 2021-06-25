#!/bin/bash -e -u -o pipefail

# Call with <sdk> <scheme> <…other args>
SDK="$1"
SCHEME="$2"
shift 2

cd "$(dirname "${BASH_SOURCE[0]}")/.."
export PROJECT_ROOT="$(pwd)"

# Set a local TMPDIR, just in case it affects the build
export TMPDIR="$PROJECT_ROOT/.build/tmp"
mkdir -p "$TMPDIR"

# Run xcodebuild with specific folders for Derived Data and Cache.
# Those will be cached upon a successful CI workflow.
exec xcodebuild \
  -sdk $SDK \
  -derivedDataPath .build/derived-data/$SDK \
  -clonedSourcePackagesDirPath .build/swift-dependencies/$SDK \
  -configuration Debug \
  -workspace FigmaKit.xcworkspace \
  -scheme "$SCHEME" \
  ${1+"$@"} \
  CACHE_ROOT="$PROJECT_ROOT/.build/derived-data/$SDK/Cache"
