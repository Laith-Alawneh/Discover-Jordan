<h1 align="center">🏛️ The Tour - Discover Jordan</h1>
<h3 align="center">A premium tourism mobile application showcasing Jordan's cultural heritage and destinations</h3>

---

### 📱 About The Project

**The Tour - Discover Jordan** is a modern Flutter mobile application designed to promote Jordan as a world-class tourism destination. The app provides an engaging, interactive experience for both local and international visitors, featuring stunning visuals, immersive content, and offline functionality.

* 🏛️ **Explore Attractions**: Discover iconic Jordanian destinations including Petra, Wadi Rum, Dead Sea, Jerash, and Aqaba
* 📚 **Interactive Content**: Rich descriptions, galleries, videos, and audio guides for each attraction
* 🎯 **Quiz Feature**: Test your knowledge about Jordan's history and culture
* ⭐ **Rating System**: Share your feedback and save your ratings locally
* ❤️ **Favorites**: Save your favorite attractions for quick access
* 🎨 **Modern UI/UX**: Glassmorphism and Neumorphism design with animated gradients
* 📴 **Offline Support**: Full functionality without internet connection
* 🌍 **RTL Support**: Right-to-left layout optimized for Arabic interface

---

### 🛠️ Tech Stack

<p align="left">
  <img src="https://skillicons.dev/icons?i=flutter,dart" />
  <img src="https://img.shields.io/badge/Flutter-3.11+-02569B?style=for-the-badge&logo=flutter&logoColor=white"/>
  <img src="https://img.shields.io/badge/Dart-3.11+-0175C2?style=for-the-badge&logo=dart&logoColor=white"/>
</p>

**Core Technologies:**
* **Flutter 3.11+** - Cross-platform mobile framework
* **Dart 3.11+** - Programming language
* **Riverpod 2.6.1** - State management
* **Google Fonts 6.2.1** - Typography
* **Video Player 2.9.3** - Video playback
* **Audio Players 6.1.0** - Audio playback
* **SharedPreferences 2.3.2** - Local data storage
* **Vibration 3.1.3** - Haptic feedback

---

### ✨ Features

#### 🎯 Core Functionality
- ✅ **Attractions Gallery**: Browse through 5+ major Jordanian destinations
- ✅ **Detailed Information**: Comprehensive details about each attraction including:
- ✅ **Video Content**: Immersive video introductions for attractions
- ✅ **Audio Guides**: Audio narration for enhanced experience
- ✅ **Interactive Quiz**: Test your knowledge with multiple-choice questions
- ✅ **Rating System**: Rate the app and save your feedback locally
- ✅ **Favorites Management**: Save and manage your favorite attractions
- ✅ **Offline Mode**: Complete functionality without internet connection

---

### 📦 Installation

#### Prerequisites
- Flutter SDK 3.11 or higher
- Dart SDK 3.11 or higher
- Android Studio / Xcode (for mobile development)
- VS Code or Android Studio (recommended IDEs)

---

### 🚀 Usage

1. **Launch the App**: Open the app to see the splash screen with animated logo
2. **Explore Home**: Browse the home screen with introduction video and quick stats
3. **View Attractions**: Navigate to attractions screen to see all destinations
4. **Read Details**: Tap any attraction to view comprehensive information
5. **Watch Videos**: Play video content for immersive experience
6. **Take Quiz**: Test your knowledge about Jordan
7. **Rate the App**: Share your feedback through the rating screen
8. **Save Favorites**: Mark your favorite attractions for quick access

---

### 📁 Project Structure

```
the_tour/
│
├── lib/
│   ├── main.dart                 # Application entry point
│   ├── app.dart                  # Main app widget and theme
│   │
│   ├── models/                   # Data models
│   │   ├── attraction.dart       # Attraction data model
│   │   └── quiz_question.dart    # Quiz question model
│   │
│   ├── providers/                # Riverpod providers
│   │   ├── attractions_provider.dart
│   │   ├── favorites_provider.dart
│   │   ├── quiz_provider.dart
│   │   └── rating_provider.dart
│   │
│   ├── services/                 # Business logic services
│   │   ├── storage_service.dart
│   │   ├── quiz_service.dart
│   │   └── rating_service.dart
│   │
│   ├── views/                    # Screen widgets
│   │   ├── splash_screen.dart
│   │   ├── home_screen.dart
│   │   ├── attractions_screen.dart
│   │   ├── attraction_detail_screen.dart
│   │   ├── quiz_screen.dart
│   │   ├── favorites_screen.dart
│   │   ├── rating_screen.dart
│   │   └── about_screen.dart
│   │
│   └── widgets/                  # Reusable UI components
│       ├── glass_card.dart
│       ├── animated_gradient_background.dart
│       ├── intro_video_player.dart
│       ├── page_transitions.dart
│       └── ...
│
├── assets/
│   ├── images/                   # Attraction images
│   ├── audio/                    # Audio guides
│   └── video/                    # Video content
│
├── android/                      # Android platform files
├── ios/                          # iOS platform files
├── web/                          # Web platform files
├── windows/                      # Windows platform files
├── linux/                        # Linux platform files
├── macos/                        # macOS platform files
│
├── pubspec.yaml                  # Dependencies and assets
└── README.md                     # This file
```

---

### 🎯 Featured Attractions

The app showcases these iconic Jordanian destinations:

1. **🏛️ Petra** - The Rose City, one of the New Seven Wonders of the World
2. **🏜️ Wadi Rum** - The Valley of the Moon, a stunning desert landscape
3. **🌊 Dead Sea** - The lowest point on Earth with unique saltwater properties
4. **🏛️ Jerash** - One of the best-preserved Roman cities outside Italy
5. **🏖️ Aqaba** - Jordan's only coastal city on the Red Sea

---

### 🎨 Design System

- **Glassmorphism**: Frosted glass effect with backdrop blur
- **Neumorphism**: Soft shadows and highlights for depth
- **Animated Gradients**: Dynamic color transitions
- **Custom Typography**: Google Fonts integration
- **Color Palette**: Dark theme with accent colors
- **Responsive Grid**: Adaptive layouts for different screen sizes

---

### 👨‍💻 Developer

**Laith Amin Alawneh**

* Mobile App Developer | Flutter Enthusiast
* Building modern, user-friendly mobile applications
* Passionate about UI/UX design and clean architecture

---

### 📝 Notes

* This project was developed as part of a software development course
* The application demonstrates modern Flutter development practices
* Full offline functionality - no internet connection required
* Optimized for both phones and tablets
* RTL (Right-to-Left) support for Arabic interface
* Local data persistence using SharedPreferences

---

### 🔄 Version History

- **v1.0** - Initial release with core features
- **v2.0** - Enhanced UI/UX with glassmorphism design
- **Current** - Latest version with all features and improvements

---

### 📄 License

This project is created for educational purposes.

---

### 🙏 Acknowledgments

* Jordan Tourism Board for inspiration
* Flutter community for excellent resources and packages
* All testers who provided valuable feedback during development

---

### 🌟 Future Enhancements

- [ ] Interactive maps integration
- [ ] Offline content packages
- [ ] Multi-language support (English/Arabic)
- [ ] Social sharing features
- [ ] Augmented Reality (AR) experiences
- [ ] Travel itinerary planner
- [ ] Weather integration
- [ ] Booking integration

---

<p align="center">
  <b>Built with ❤️ using Flutter</b>
  <br>
  <i>Discover the beauty of Jordan 🇯🇴</i>
</p>
