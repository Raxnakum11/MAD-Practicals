# Gujarat Tourist Guide

A comprehensive Flutter application that serves as a digital companion for tourists visiting Gujarat. This mobile app provides an intuitive interface for exploring tourist destinations, booking tickets, and managing travel itineraries.

## Features

### 🔐 User Authentication
- **User Registration**: New users can create accounts with email validation
- **Secure Login**: Password-protected user authentication system
- **Session Management**: Persistent login sessions using SharedPreferences

### 🎫 Ticket Management
- **Ticket Booking**: Book tickets for various tourist attractions
- **Unique Ticket Generation**: Each ticket has a unique ID for easy tracking
- **Digital Tickets**: E-tickets with QR code placeholders for entry verification
- **Booking History**: View all past and upcoming bookings
- **Ticket Status Tracking**: Active, Used, Expired, and Cancelled ticket states

### 🏛️ Tourist Places Discovery
- **Curated Destinations**: Pre-loaded with popular Gujarat tourist places including:
  - Statue of Unity (Kevadia)
  - Gir National Park (Junagadh)
  - Rann of Kutch (Kutch District)
  - Somnath Temple (Gir Somnath)
  - Sabarmati Ashram (Ahmedabad)
  - Dwarka (Dwarka District)
- **Category Filtering**: Filter places by Monument, Wildlife, Desert, Temple, Historical
- **Search Functionality**: Search places by name or location
- **Detailed Information**: Complete place details with ratings, timings, and pricing
- **Place Details View**: Rich detailed pages with booking options

### 📱 User Experience
- **Modern UI Design**: Clean, intuitive interface with Google Fonts (Poppins)
- **Bottom Navigation**: Easy navigation between Home, Places, Tickets, and Profile
- **Splash Screen**: Beautiful app launch experience
- **Dashboard**: Personalized welcome screen with quick actions
- **Profile Management**: View and manage user profile information

## Technical Architecture

### 🗄️ Database Layer
- **SQLite Database**: Local data storage using sqflite
- **Database Helper**: Centralized database operations
- **Sample Data**: Pre-populated with Gujarat tourist destinations

### 🏗️ App Structure
```
lib/
├── models/           # Data models (User, TouristPlace, Ticket)
├── services/         # Business logic (DatabaseHelper, AuthService)
├── screens/          # UI screens and pages
└── main.dart        # App entry point
```

### 📦 Dependencies
- `sqflite`: SQLite database for local data storage
- `shared_preferences`: User session management
- `google_fonts`: Beautiful typography with Poppins font
- `intl`: Date formatting and internationalization
- `uuid`: Unique ID generation for tickets
- `path`: File system path manipulation

## Getting Started

### Prerequisites
- Flutter SDK (latest stable version)
- Dart SDK
- Android Studio / VS Code with Flutter extensions

### Installation
1. Clone the repository
2. Navigate to the project directory
3. Run `flutter pub get` to install dependencies
4. Run `flutter run` to start the application

### First Time Setup
1. Launch the app
2. Create a new account using the registration screen
3. Login with your credentials
4. Explore Gujarat tourist places
5. Book your first ticket!

## App Flow

1. **Splash Screen** → Checks user authentication status
2. **Login/Registration** → User authentication
3. **Home Dashboard** → Welcome screen with quick actions
4. **Places List** → Browse and filter tourist destinations
5. **Place Details** → View complete information about a destination
6. **Ticket Booking** → Select dates and number of visitors
7. **Ticket Confirmation** → Digital ticket with unique ID
8. **My Tickets** → View all bookings and ticket status
9. **Profile** → User information and app settings

## Database Schema

### Users Table
- id, full_name, email, password, phone_number, created_at

### Tourist Places Table
- id, name, description, location, category, ticket_price, image_url, rating, opening_hours, best_time_to_visit

### Tickets Table
- id, ticket_id, user_id, tourist_place_id, tourist_place_name, visit_date, number_of_visitors, total_price, booked_at, status

## Featured Gujarat Destinations

- **Statue of Unity**: World's tallest statue, Kevadia
- **Gir National Park**: Last refuge of Asiatic lions
- **Rann of Kutch**: White salt desert, famous for Rann Utsav
- **Somnath Temple**: One of the twelve Jyotirlinga shrines
- **Sabarmati Ashram**: Mahatma Gandhi's historic residence
- **Dwarka**: Ancient city and Char Dham pilgrimage site

## Contributing

This project is part of a mobile application development practical. Feel free to enhance features, improve UI/UX, or add new functionality.

## License

This project is created for educational purposes as part of mobile application development coursework.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
