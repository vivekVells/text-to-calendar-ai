# Text to Calendar AI

Transform natural language into calendar events instantly with this AI-powered assistant that turns your words into scheduled actions.

## Project Overview

This project demonstrates how to build a complete system for converting natural language instructions into structured actions, using calendar events as our example.

The series is broken down into modules:

1. **Calendar API Foundation** - Create a robust REST API for Google Calendar
2. **Words to Calendar Events** - Convert natural language to structured calendar events
3. **Voice Command Integration** - Add speech recognition for hands-free calendar entry
4. **Wake Word Detection** - Add "Hey Calendar" always-on listening for truly hands-free operation

## Tutorial Resources

Check out the complete step-by-step guides for this project:

### Video Tutorials

- [Complete YouTube Playlist](https://www.youtube.com/watch?v=AB3i7E0hzEk&list=PL7qSPQlgOO9LA10Dn6sj3kEO9E6j8SpdS)
- [Part 1: Calendar API](https://youtu.be/AB3i7E0hzEk)
- [Part 2: Words to Calendar Events](https://youtu.be/QspgMZ0Ehvo)
- [Part 3: Voice Command Integration](https://youtu.be/voice-command-video-link)
- [Part 4: Wake Word Detection](https://youtu.be/wake-word-video-link)

### Written Guides

- **Part 1: Calendar API Foundation**
  - [Project Documentation](part-1-calendar-api.md)
  - [Medium Blog Post](https://medium.com/@vivekvells/build-a-google-calendar-api-with-express-js-7f9955caeb88)
- **Part 2: Words to Calendar Events**
  - [Project Documentation](part-2-words-to-calendar-events.md)
  - [Medium Blog Post](https://medium.com/@vivekvells/part-2-text-to-action-words-to-calendar-events-building-a-smart-calendar-ai-assistant-3ca928705442)
- **Part 3: Voice Command Integration**
  - [Project Documentation](part-3-voice-commands.md)
  - [Medium Blog Post](https://medium.com/@vivekvells/part-3-text-to-action-voice-command-integration-building-a-smart-calendar-ai-assistant)
- **Part 4: Wake Word Detection**
  - [Project Documentation](part-4-wake-word-detection-using-web-speech-api.md)
  - [Setup Guide](WAKE_WORD_SETUP.md)

## Architecture

The project follows a clean, modular architecture to make the tutorial process easier to follow:

### Frontend

- **Modular CSS**: Each tutorial part has its own dedicated CSS file
  - `css/base.css`: Shared styles across all interfaces
  - `css/main.css`: Shared styles across all interfaces
  - `css/components/part1-calendar-form.css`: Styles for the standard form interface
  - `css/components/part2-nlp.css`: Styles for the natural language text interface
  - `css/components/part3-voice.css`: Styles for the voice command interface
  - `css/components/part-4-wake-word.css`: Wake word detection interface styles

### Backend

- **Express.js Server**: Handles API requests and serves the web interface
- **OAuth2 Authentication**: Secures access to Google Calendar
- **NLP Processing**: Converts natural language to structured data using Ollama
- **Calendar Integration**: Creates and manages events via Google Calendar API
- **Wake Word Detection**: Always-on listening **using Web Speech API**

### Integration

- Each part of the tutorial builds on the previous one
- The same backend API can be used with all four interfaces
- Common code is shared to demonstrate proper abstraction

## Quick Start

1. Clone this repository
2. Install dependencies: `npm install`
3. Set up required environment variables in `.env`
4. Start the server: `npm start`
5. Visit <http://localhost:3000>

See the individual module documentation for detailed setup instructions:

- [Part 1 Setup](part-1-calendar-api.md#setup)
- [Part 2 Setup](part-2-words-to-calendar-events.md#prerequisites)
- [Part 3 Setup](part-3-voice-commands.md#prerequisites)
- [Part 4 Setup](part-4-wake-word-detection-using-web-speech-api.md#prerequisites)

## Features

- **Google Calendar Integration** with OAuth2 authentication
- **Natural Language Processing** to convert plain text to calendar events
- **Voice Command Interface** using Web Speech API
- **Wake Word Detection** with "Hey Calendar" activation
- **Timezone-aware** date/time handling
- **Web Interface** with four input methods:
  - Traditional form entry
  - Natural language text input
  - Voice commands (press-and-hold)
  - Wake word detection using web-speech-api (always-on listening)
- **Command-line Testing** tools

## Interface Options

| Interface | URL | Description |
|-----------|-----|-------------|
| Standard Form | `/` | Traditional calendar form |
| Text Input | `/text-to-event.html` | Natural language text processing |
| Voice Commands | `/voice-commands.html` | Press-and-hold voice interface |
| Wake Word Demo | `/part-4-wake-word-detection-using-web-speech-api.html` | Always-on "Hey Calendar" detection |

## Wake Word Commands

Once wake word detection is enabled, try these commands:

```
"Hey Calendar, schedule a team meeting tomorrow at 2pm"
"Hey Calendar, create a dentist appointment on Friday at 10am"  
"Hey Calendar, set up lunch with Sarah next Tuesday at noon"
"Hey Calendar, book a conference call next Monday from 9am to 10am"
```

## API Endpoints

| Endpoint | Description |
|----------|-------------|
| `POST /api/create-event` | Create event from structured JSON data |
| `POST /api/text-to-event` | Create event from natural language text |

## Testing with cURL

> Use your timezone or run `test-text-to-event.sh`

```bash
# Create event with natural language
curl -X POST http://localhost:3000/api/text-to-event \
  -H "Content-Type: application/json" \
  -H "X-Timezone: America/New_York" \
  -d '{"text": "Schedule a team meeting tomorrow at 3pm for 1 hour"}'
```

## Browser Compatibility

### Wake Word Detection

- ✅ **Chrome** (recommended)
- ✅ **Edge**
- ✅ **Safari**
- ⚠️ **Firefox** (requires configuration)

### General Features

- ✅ All modern browsers support text and form interfaces
- ✅ Voice commands work on most modern browsers
- ⚠️ Wake word detection requires Web Speech API support

## Privacy & Security

- **Local wake word processing** (no audio sent to servers until command detected)
- **Explicit microphone permissions** required
- **OAuth2 secure authentication** with Google
- **No persistent audio storage**

## Development

### File Structure

```
text-to-calendar/
├── public/
│   ├── index.html                                           # Part 1: Form interface
│   ├── text-to-event.html                                   # Part 2: Text interface  
│   ├── voice-commands.html                                  # Part 3: Voice interface
│   ├── part-4-wake-word-detection-using-web-speech-api.html                      # Part 4: Wake word
│   └── css/
│       ├── main.css                                         # Shared styles
│       └── components/
│           └── part-4-wake-word.css                        # Wake word specific styles
├── app.js                                                   # Express server
├── nlpService.js                                            # Natural language processing
├── utils/calendarUtils.js                                   # Calendar utilities
├── part-1-calendar-api.md                                   # Part 1 documentation
├── part-2-words-to-calendar-events.md                       # Part 2 documentation
├── part-3-voice-commands.md                                 # Part 3 documentation
├── part-4-wake-word-detection-using-web-speech-api.md                            # Part 4 documentation
├── WAKE_WORD_SETUP.md                                       # Wake word setup guide
├── test-wake-word-setup.sh                                  # Wake word test script
└── README.md                                                # This file
```

### Adding New Features

1. **New Interface**: Create new HTML file in `/public/`
2. **Styling**: Add component CSS in `/public/css/components/`
3. **Backend**: Extend existing API endpoints in `app.js`
4. **Documentation**: Update README and create setup guides

## Troubleshooting

### Wake Word Issues

- Ensure microphone permissions are granted
- Use Chrome for best compatibility
- Check [Wake Word Setup Guide](WAKE_WORD_SETUP.md) for detailed troubleshooting

### General Issues

- Verify Google Calendar authentication
- Check Ollama is running (for text processing)
- Ensure environment variables are configured
- Check browser console for error messages

## Contributing

This project is designed for educational purposes. Feel free to:

1. **Fork** the repository
2. **Add features** or improve existing ones
3. **Create issues** for bugs or feature requests
4. **Submit pull requests** with improvements

## License

MIT License - feel free to use this code for your own projects!

---
