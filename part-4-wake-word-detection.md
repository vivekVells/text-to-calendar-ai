# Part 4: Wake Word Detection

> Link to [Blog post](https://medium.com/@vivekvells/part-4-text-to-action-wake-word-detection-using-web-speech-api-building-a-smart-calendar-ai-assistant)

This document explains how to implement wake word detection for our Calendar AI Assistant, building on the foundation from Parts 1, 2, and 3.

## Overview

In this module, we add always-on wake word detection that allows users to create calendar events by saying "Hey Calendar, schedule a meeting tomorrow at 3pm" without pressing any buttons.

We'll use the Web Speech API to:

- Continuously listen for the wake phrase "Hey Calendar"
- Process spoken commands automatically when detected
- Provide voice feedback and visual status indicators

This creates a completely hands-free experience for creating calendar events.

## Prerequisites

Before starting this part, make sure you have:

1. Completed [Part 1: Calendar API Foundation](part-1-calendar-api.md), [Part 2: Words to Calendar Events](part-2-words-to-calendar-events.md), and [Part 3: Voice Command Integration](part-3-voice-commands.md)
2. A modern browser that supports the Web Speech API (Chrome works best)
3. A microphone connected to your computer with browser permissions granted
4. Ollama running locally with the selected model (as configured in Part 2)

## Implementation

### 1. Understanding Wake Word Detection

Wake word detection is the technology that powers voice assistants like "Hey Google", "Alexa", and "Hey Siri". Our implementation uses continuous listening with smart filtering to:

- Always listen for the specific trigger phrase "Hey Calendar"
- Process commands only when the wake word is detected
- Preserve privacy by keeping processing local until activated

### 2. Creating the Wake Word Interface

We've created a new page (`part-4-wake-word-detection-using-web-speech-api.html`) with an always-on listening system that:

- Starts continuous listening when enabled
- Detects "Hey Calendar" in the audio stream
- Processes the following command automatically
- Provides both visual and voice confirmation

Key features:

- Visual status indicators (ON/OFF/Processing states)
- Voice feedback for confirmations
- Automatic reset after each command
- Browser compatibility detection

### 3. How It Works

1. User clicks "Enable Hey Calendar" to start always-on listening
2. System continuously monitors audio for the wake phrase
3. When "Hey Calendar" is detected, the command is extracted
4. The command is sent to our existing `/api/text-to-event` endpoint
5. The backend processes the text using Ollama (same as Part 2)
6. A calendar event is created
7. The system provides both visual and spoken confirmation
8. Automatically resets to listen for the next wake word

### 4. Continuous Listening Implementation

Instead of complex session management, we use continuous recognition with smart filtering:

```javascript
// Configure for maximum accuracy
recognition.continuous = true;
recognition.interimResults = true;

// Smart wake word detection
recognition.onresult = (event) => {
  if (isProcessingCommand) return; // Ignore while busy
  
  const transcript = getFinalTranscript(event);
  if (transcript && transcript.includes('hey calendar')) {
    processWakeWordCommand(transcript);
  }
};
```

### 5. Duplicate Prevention

We prevent the same command from being processed multiple times:

```javascript
function processTranscript(transcript) {
  // Avoid processing the same command twice
  if (transcript === lastProcessedCommand) {
    return;
  }
  
  if (transcript.includes('hey calendar')) {
    lastProcessedCommand = transcript;
    handleWakeWordCommand(transcript);
  }
}
```

### 6. Natural Speech Patterns

Users speak their complete command naturally in one phrase:

```
✅ Good: "Hey Calendar, schedule a meeting tomorrow at 3pm"
✅ Good: "Hey Calendar, create a dentist appointment Friday at 10am"
```

## Testing

1. Start your Express server: `npm start`
2. Make sure Ollama is running locally
3. Open Chrome and navigate to <http://localhost:3000/part-4-wake-word-detection-using-web-speech-api.html>
4. Authenticate with Google if you haven't already
5. Click "Enable Hey Calendar"
6. Say "Hey Calendar, schedule a team meeting tomorrow at 2pm"
7. Watch as your event is created and announced

## Troubleshooting

If you encounter issues:

- **Wake word not detected**: Speak clearly, use Chrome, check microphone permissions
- **Commands not processed**: Ensure Ollama is running, check internet connection
- **Browser compatibility**: Use Chrome for best results
- **Microphone issues**: Check browser permissions and system microphone settings

## Next Steps

With wake word detection implemented, our Calendar AI Assistant now offers four different ways to create events:

1. Standard form interface
2. Natural language text input
3. Voice commands (press-and-hold)
4. Wake word detection (always-on listening)

Future enhancements could include:

- Custom wake words using machine learning
- Multiple wake word support
- Voice profile recognition
- Context-aware commands

## Resources

- [Web Speech API Documentation](https://developer.mozilla.org/en-US/docs/Web/API/Web_Speech_API)
- [Google Calendar API](https://developers.google.com/calendar)
- [Ollama Documentation](https://ollama.ai/docs)
- [Part 1: Calendar API Foundation](part-1-calendar-api.md)
- [Part 2: Words to Calendar Events](part-2-words-to-calendar-events.md)
- [Part 3: Voice Command Integration](part-3-voice-commands.md)
