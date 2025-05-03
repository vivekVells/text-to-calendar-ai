# Part 3: Voice Command Integration

> Link to [Blog post](https://medium.com/@vivekvells/part-3-text-to-action-adding-voice-commands-to-your-calendar-assistant-078776ccde4e)

This document explains how to implement voice commands for our Calendar AI Assistant, building on the foundation from Parts 1 and 2.

## Overview

In this module, we add a voice interface that allows users to create calendar events by speaking commands like "Schedule a team meeting tomorrow at 2pm" instead of typing them.

We'll use the Web Speech API to:

- Convert spoken commands to text (Speech Recognition)
- Provide spoken feedback to users (Speech Synthesis)

This creates a completely hands-free experience for creating calendar events.

## Prerequisites

Before starting this part, make sure you have:

1. Completed [Part 1: Calendar API Foundation](part-1-calendar-api.md) and [Part 2: Words to Calendar Events](part-2-words-to-calendar-events.md)
2. A modern browser that supports the Web Speech API (Chrome works best)
3. A microphone connected to your computer
4. Ollama running locally with the selected model (as configured in Part 2)

## Implementation

### 1. Understanding the Web Speech API

The Web Speech API has two main components:

- **SpeechRecognition**: Converts spoken words to text
- **SpeechSynthesis**: Converts text to spoken words

Browser support varies, with Chrome offering the best compatibility.

### 2. Creating the Voice Interface

We've created a new page (`voice-commands.html`) with a press-and-hold microphone button that:

- Starts listening when pressed
- Continues recording while held
- Stops and processes when released

This provides a natural, intuitive interface similar to voice assistants like Google Assistant.

Key features:

- Visual feedback during recording (green pulsing animation)
- Real-time transcript display
- Spoken confirmation of created events
- Example commands that speak when clicked

### 3. How It Works

1. User presses and holds the microphone button
2. Speech is converted to text in real-time and displayed
3. When the button is released, the text is sent to our existing `/api/text-to-event` endpoint
4. The backend processes the text using Ollama (same as Part 2)
5. A calendar event is created
6. The system provides both visual and spoken confirmation

### 4. Press-and-Hold Implementation

Instead of a toggle button, we use press-and-hold events for a more intuitive experience:

```javascript
// Press and hold to speak pattern
micButton.addEventListener('mousedown', startListening);
micButton.addEventListener('touchstart', startListening);
document.addEventListener('mouseup', stopListening);
document.addEventListener('touchend', stopListening);
```

This pattern works on both desktop and mobile devices.

### 5. Handling Speech Recognition Results

We process both interim (in-progress) and final results:

```javascript
recognition.onresult = (event) => {
  interimTranscript = '';
  
  for (let i = event.resultIndex; i < event.results.length; i++) {
    const transcript = event.results[i][0].transcript;
    
    if (event.results[i].isFinal) {
      finalTranscript += transcript;
    } else {
      interimTranscript += transcript;
    }
  }
  
  transcriptEl.innerHTML = `
    <div class="final">${finalTranscript}</div>
    <div class="interim"><em>${interimTranscript}</em></div>
  `;
};
```

### 6. Adding Voice Feedback

We provide spoken feedback using the Speech Synthesis API:

```javascript
function speak(text) {
  // Cancel any ongoing speech
  speechSynthesis.cancel();
  
  // Create a new utterance
  const utterance = new SpeechSynthesisUtterance(text);
  utterance.lang = 'en-US';
  utterance.rate = 1.0;
  utterance.pitch = 1.0;
  
  // Speak the text
  speechSynthesis.speak(utterance);
}
```

## Testing

1. Start your Express server: `npm start`
2. Make sure Ollama is running locally
3. Open Chrome and navigate to <http://localhost:3000/voice-commands.html>
4. Authenticate with Google if you haven't already
5. Press and hold the microphone button while speaking a command
6. Release the button when done
7. Watch as your event is created and announced

## Troubleshooting

If you encounter issues:

- **Microphone not working**: Check browser permissions for the microphone
- **Recognition errors**: Speak clearly and in a quiet environment
- **Browser compatibility**: Use Chrome for best results
- **No speech detected**: Make sure you're speaking while holding the button
- **Processing errors**: Check the browser console for details

## Next Steps

With voice commands implemented, our Calendar AI Assistant now offers three different ways to create events:

1. Standard form interface
2. Natural language text input
3. Voice commands

Future enhancements could include:

- Adding voice command cancellation ("cancel that")
- Supporting more complex commands ("move my meeting from Tuesday to Wednesday")
- Creating recurring events ("schedule a weekly team meeting every Monday at 9am")
- Implementing custom voice confirmations for different event types

## Resources

- [Web Speech API Documentation](https://developer.mozilla.org/en-US/docs/Web/API/Web_Speech_API)
- [Google Calendar API](https://developers.google.com/calendar)
- [Ollama Documentation](https://ollama.ai/docs)
- [MDN SpeechRecognition](https://developer.mozilla.org/en-US/docs/Web/API/SpeechRecognition)
- [MDN SpeechSynthesis](https://developer.mozilla.org/en-US/docs/Web/API/SpeechSynthesis)
