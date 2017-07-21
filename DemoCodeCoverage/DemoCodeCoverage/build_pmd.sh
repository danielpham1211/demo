#!/bin/sh
# Generate PMD reporter
# Step 1: Create xcodebuild.log
xcodebuild clean -project DemoCodeCoverage.xcodeproj/ -scheme 'DemoCodeCoverage' -configuration Debug
xcodebuild build -target DemoCodeCoverage -configuration Debug -scheme DemoCodeCoverage CLANG_ENABLE_MODULE_DEBUGGING=NO CODE_SIGN_IDENTITY="" CODE_SIGNING_REQUIRED=NO | tee xcodebuild.log
# Step 2: Create compile_commands.json
oclint-xcodebuild
# Step 3: Create pmd_oclint.xml
oclint-json-compilation-database -- -max-priority-1 '1' -max-priority-2 '50' -max-priority-3 '100' -report-type pmd -o pmd_oclint.xml
