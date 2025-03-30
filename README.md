# MuzzCodeChallenge

This project is a technical assessment for the iOS Lead Engineer position at Muzz. It demonstrates modern iOS development practices, clean architecture, and SwiftUI implementation.

## How long I spent on this assignment?
- About 5 hours

## Project Overview

The MuzzCodeChallenge is a chat application built with SwiftUI that showcases:
- Modern SwiftUI architecture
- SwiftData for persistence
- Clean MVVM architecture
- Responsive UI with animations
- Localization support
- Light and Dark mode support

## Architecture

The project follows a clean MVVM (Model-View-ViewModel) architecture with the following structure:

### Features
- `Chat/`: Contains all chat-related views and view models
  - Views: UI components for displaying messages and chat interface
  - ViewModels: Business logic and state management

## Technical Stack

- **Framework**: SwiftUI
- **Data Persistence**: SwiftData
- **Architecture**: MVVM
- **Minimum iOS Version**: iOS 17.0 (SwiftData requirement)
- **Language**: Swift

## Limitations
I decided to use InputBarAccessoryView library as instructed by Muzz engineering team, but the it's implementation with SwiftUI is flawed, there is an issue with the adjustable height of the TextField.
I managed to set a fixed Height for the TextField, but once you start breaking lines, the height does not adapt properly. 

I did  try to briefly look through their GitHub issues, see if someone else had this issue before, but could not find anything conclusive.

I decided to focus on more pressing things, such as architecture and the chat functionality itself.

## Key Features

1. **Real-time Chat Interface**
   - Animated message appearance
   - Different styles for sent/received messages
   - Timestamp grouping

2. **Data Management**
   - Persistent storage using SwiftData
   - Efficient message grouping and organization

3. **UI/UX**
   - Custom theme implementation
   - Smooth animations
   - Responsive layout

4. **Localization**
   - Support for multiple languages
   - Dynamic timestamp formatting

## Setup Instructions

1. Clone the repository
2. Open `MuzzCodeChallenge.xcodeproj` in Xcode 15.0 or later
3. Build and run the project

## Requirements

- Xcode 15.0+
- iOS 17.0+
- Swift 5.9+

## Author

Raphael Velasqua
