# Text to Calendar AI

Transform natural language into calendar events instantly with this AI-powered assistant that turns your words into scheduled actions.

## Project Overview

This project demonstrates how to build a complete system for converting natural language instructions into structured actions, using calendar events as our example.

The series is broken down into modules:

1. **Calendar API Foundation** - Create a robust REST API for Google Calendar
2. **Words to Calendar Events** - Convert natural language to structured calendar events
3. **Voice Command Integration** - Add speech recognition for hands-free calendar entry

## Tutorial Resources

Check out the complete step-by-step guides for this project:

### Video Tutorials

- [Complete YouTube Playlist](https://www.youtube.com/watch?v=AB3i7E0hzEk&list=PL7qSPQlgOO9LA10Dn6sj3kEO9E6j8SpdS)
- [Part 1: Calendar API](https://youtu.be/AB3i7E0hzEk)
- [Part 2: Words to Calendar Events](https://youtu.be/QspgMZ0Ehvo)
- [Part 3: Voice Command Integration](https://youtu.be/voice-command-video-link)

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

## Architecture

The project follows a clean, modular architecture to make the tutorial process easier to follow:

### Frontend
- **Modular CSS**: Each tutorial part has its own dedicated CSS file
  - `css/base.css`: Shared styles across all interfaces
  - `css/components/part1-calendar-form.css`: Styles for the standard form interface
  - `css/components/part2-nlp.css`: Styles for the natural language text interface
  - `css/components/part3-voice.css`: Styles for the voice command interface

### Backend
- **Express.js Server**: Handles API requests and serves the web interface
- **OAuth2 Authentication**: Secures access to Google Calendar
- **NLP Processing**: Converts natural language to structured data using Ollama
- **Calendar Integration**: Creates and manages events via Google Calendar API

### Integration
- Each part of the tutorial builds on the previous one
- The same backend API can be used with all three interfaces
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

## Features

- **Google Calendar Integration** with OAuth2 authentication
- **Natural Language Processing** to convert plain text to calendar events
- **Voice Command Interface** using Web Speech API
- **Timezone-aware** date/time handling
- **Web Interface** with three input methods:
  - Traditional form entry
  - Natural language text input
  - Voice commands
- **Command-line Testing** tools

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
