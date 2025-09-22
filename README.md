# Learn ABCD & 123 - Educational Flutter App for Children

A colorful and interactive Flutter application designed to help children learn letters (A-Z) and numbers (1-10) with engaging UI, sound effects, and animations.

## Features

### 🔤 Letters Learning (A-Z)
- **Interactive Letter Cards**: Each letter is presented with:
  - Large, colorful letter in a circle
  - Associated word (Apple, Ball, Cat, etc.)
  - Fun emoji representation
  - Color-coded design for visual appeal
- **Text-to-Speech**: Tap any letter to hear:
  - Letter pronunciation
  - Associated word
  - Example: "A for Apple"
- **Visual Feedback**: Cards animate when tapped
- **Educational Content**: Real-world examples for each letter

### 🔢 Numbers Learning (1-10)
- **Interactive Number Cards**: Each number features:
  - Large, colorful number in a circle
  - Number word (One, Two, Three, etc.)
  - Visual representation with emojis
  - Counting dots for visual counting
- **Text-to-Speech**: Tap any number to hear:
  - Number pronunciation
  - Counting sequence (1, 2, 3...)
  - Example: "3. Three. Let's count: 1, 2, 3"
- **Visual Learning**: Dots help children understand quantity
- **Progressive Counting**: Audio counts from 1 to the selected number

### 🎨 User Interface Features
- **Gradient Backgrounds**: Beautiful color transitions
- **Google Fonts**: Child-friendly Comic Neue font
- **Smooth Animations**: 
  - Scale animations for letters
  - Bounce animations for numbers
  - Smooth transitions between screens
- **Responsive Design**: Works on different screen sizes
- **Intuitive Navigation**: Easy-to-use interface for children

### 🔊 Audio Features
- **Flutter TTS Integration**: High-quality text-to-speech
- **Optimized Speech Settings**:
  - Slower speech rate for clarity (0.5-0.6x)
  - Higher pitch for child-friendly voice
  - Proper pronunciation of letters and words
- **Interactive Sound**: Tap-to-hear functionality
- **Help Audio**: Instructions and tips

## Getting Started

### Installation
1. Navigate to project directory: `cd learn_abcd_123`
2. Install dependencies: `flutter pub get`
3. Run the application: `flutter run`
4. Select target platform (Android, iOS, Web, Desktop)

## Usage
- **Choose learning mode**: Tap "ABC 📚" for letters or "123 🔢" for numbers
- **Interactive learning**: Tap any card to hear pronunciation and examples
- **Get help**: Tap the help button (?) for instructions

## Technical Stack
- Flutter 3.7.0+, Dart
- flutter_tts ^4.1.0 (Text-to-Speech)
- google_fonts ^6.2.1 (Typography)
- Supports iOS, Android, Web, Desktop

*Making learning fun, interactive, and accessible for children!*
