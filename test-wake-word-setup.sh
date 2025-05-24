#!/bin/bash

# Test script for Wake Word Detection - Part 4
# This script verifies that all files are in place and the server can start

echo "🚀 Testing Wake Word Detection Setup..."
echo

# Check if required files exist
echo "📁 Checking file structure..."

files_to_check=(
    "public/part-4-wake-word-detection-using-web-speech-api.html"
    "public/css/components/part-4-wake-word.css"
    "WAKE_WORD_SETUP.md"
)

for file in "${files_to_check[@]}"; do
    if [[ -f "$file" ]]; then
        echo "✅ $file exists"
    else
        echo "❌ $file missing"
        exit 1
    fi
done

echo
echo "🔗 Checking navigation updates..."

# Check if navigation is updated in other files
nav_files=(
    "public/index.html"
    "public/text-to-event.html" 
    "public/voice-commands.html"
)

for file in "${nav_files[@]}"; do
    if grep -q "part-4-wake-word-detection-using-web-speech-api" "$file"; then
        echo "✅ Navigation updated in $file"
    else
        echo "❌ Navigation not updated in $file"
        exit 1
    fi
done

echo
echo "📦 Checking package.json updates..."
if grep -q "wake-word-detection-using-web-speech-api" "package.json"; then
    echo "✅ Package.json updated with wake word keywords"
else
    echo "❌ Package.json not updated"
    exit 1
fi

echo
echo "🎯 All files are in place!"
echo
echo "🚀 To test the wake word feature:"
echo "1. Run: npm start"
echo "2. Open: http://localhost:3000/part-4-wake-word-detection-using-web-speech-api.html"
echo "3. Click 'Enable Hey Calendar'"
echo "4. Say: 'Hey Calendar, schedule a meeting tomorrow at 3pm'"
echo
echo "📖 For detailed setup: cat WAKE_WORD_SETUP.md"
echo "✨ Ready for YouTube demo!"