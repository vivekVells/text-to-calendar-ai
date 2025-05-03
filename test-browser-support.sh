#!/bin/bash
# Test browser support for Web Speech API
# Usage: ./test-browser-support.sh
# Make this script executable: chmod +x test-browser-support.sh

echo "=== Web Speech API Browser Compatibility Check ==="
echo ""
echo "This script will open your browser to test if it supports"
echo "the Web Speech API needed for voice commands."
echo ""
echo "Press Enter to launch the test page..."
read -r

# Create a temporary HTML file
TEST_FILE=$(mktemp -t webspeech-test.XXXXXX.html)

# Write the test HTML
cat > "$TEST_FILE" << EOF
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Web Speech API Test</title>
  <style>
    body { font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto; padding: 20px; }
    .success { color: green; font-weight: bold; }
    .error { color: red; font-weight: bold; }
    .result { margin: 10px 0; padding: 10px; border: 1px solid #ccc; }
  </style>
</head>
<body>
  <h1>Web Speech API Compatibility Test</h1>
  
  <div class="result" id="recognition-result">
    <h2>Speech Recognition</h2>
    <div id="recognition-status">Testing...</div>
  </div>
  
  <div class="result" id="synthesis-result">
    <h2>Speech Synthesis</h2>
    <div id="synthesis-status">Testing...</div>
  </div>
  
  <p><strong>Note:</strong> If both tests pass, your browser is compatible with the Voice Commands feature.</p>
  
  <script>
    // Test Speech Recognition
    const recognitionStatus = document.getElementById('recognition-status');
    if ('SpeechRecognition' in window || 'webkitSpeechRecognition' in window) {
      recognitionStatus.classList.add('success');
      recognitionStatus.innerHTML = 'SUPPORTED ✓<br>Your browser supports Speech Recognition.';
    } else {
      recognitionStatus.classList.add('error');
      recognitionStatus.innerHTML = 'NOT SUPPORTED ✗<br>Your browser does not support Speech Recognition. Please try Chrome.';
    }
    
    // Test Speech Synthesis
    const synthesisStatus = document.getElementById('synthesis-status');
    if ('speechSynthesis' in window) {
      synthesisStatus.classList.add('success');
      synthesisStatus.innerHTML = 'SUPPORTED ✓<br>Your browser supports Speech Synthesis.';
      
      // Say something
      setTimeout(() => {
        const utterance = new SpeechSynthesisUtterance('Your browser supports the Web Speech API');
        speechSynthesis.speak(utterance);
      }, 1000);
    } else {
      synthesisStatus.classList.add('error');
      synthesisStatus.innerHTML = 'NOT SUPPORTED ✗<br>Your browser does not support Speech Synthesis. Please try Chrome.';
    }
  </script>
</body>
</html>
EOF

# Determine OS and open the file accordingly
if [[ "$OSTYPE" == "darwin"* ]]; then
  # macOS
  open "$TEST_FILE"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
  # Linux
  if command -v xdg-open > /dev/null; then
    xdg-open "$TEST_FILE"
  else
    echo "Could not open browser automatically. Please open this file manually:"
    echo "$TEST_FILE"
  fi
elif [[ "$OSTYPE" == "msys" || "$OSTYPE" == "win32" ]]; then
  # Windows with Git Bash or similar
  start "$TEST_FILE"
else
  echo "Could not open browser automatically. Please open this file manually:"
  echo "$TEST_FILE"
fi

echo ""
echo "Browser test initiated. Please check your browser window."
echo "When you're done, you can close the browser tab and press Ctrl+C to exit this script."

# Keep the script running so the temp file doesn't get deleted
sleep 600

# Cleanup temp file (this may not execute if user Ctrl+C's)
rm -f "$TEST_FILE"
