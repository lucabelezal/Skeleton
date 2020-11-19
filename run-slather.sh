#!/bin/sh

set -o pipefail
        xcodebuild test-without-building \
        -workspace SkeletonApp.xcworkspace\
        -scheme Skeleton \
        -destination 'platform=iOS Simulator,name=iPhone 11' \
        -derivedDataPath build \
        -enableCodeCoverage YES \
        | xcpretty

slather coverage -s