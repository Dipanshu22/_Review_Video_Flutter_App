# Review_Video_App

A Flutter application that simulates a video review platform with two user roles: Artist and Director. The app includes a video player, a comment section, and the ability to reply to comments, along with user-friendly features like a search bar and timestamp markers for comments.

## Project Directory Structure
```bash
review_video_app/
📦 review_video_app
 ┣ 📂lib
 ┃ ┣ 📂assets
 ┃ ┃ ┗ 📜video.mp4
 ┃ ┣ 📜main.dart                   # App entry point
 ┃ ┣ 📜app.dart                    # Contains MyApp widget
 ┃ ┣ 📂models
 ┃ ┃ ┗ 📜comment.dart              # Comment model for storing comments and replies
 ┃ ┣ 📂providers
 ┃ ┃ ┗ 📜video_provider.dart       # Provider for managing video state and comments
 ┃ ┣ 📂screens
 ┃ ┃ ┣ 📜home_screen.dart          # Home screen for role selection
 ┃ ┃ ┗ 📜video_review_screen.dart  # Main screen for video review (Artist/Director views)
 ┃ ┣ 📂widgets
 ┃ ┃ ┣ 📜video_player_widget.dart  # Video player with play/pause and progress indicator
 ┃ ┃ ┣ 📜comment_section.dart      # Comment section with search, add, and reply features
 ┃ ┃ ┗ 📜custom_seek_bar.dart      # to mark comment timestamp on the seekbar

```
## Features
### Role Selection
- **Artist**: Can reply to comments.
- **Director**: Can add new comments.

### 🎬 Video Player
- Play/Pause functionality on the video.
- Seek bar with markers indicating comment timestamps.
- Fully responsive design supporting:
  - **Landscape Mode**
  - **Portrait Mode**

### 💬 Comment Section
- **Add Comments**: Directors can add comments with specific timestamps.
- **Reply to Comments**: Artists can reply to existing comments.
- **Search Comments**: Includes a keyword search bar for quick navigation of comments.

### 📱 Responsive UI
- Dynamic layouts for portrait and landscape.
## Dependencies
The app uses the following packages. Ensure they are included in your pubspec.yaml file:
```bash
dependencies:
  flutter:
    sdk: flutter
  provider: ^6.1.2
  video_player: ^2.9.2

flutter:
  uses-material-design: true
  assets:
    - lib/assets/video.mp4
```

## How to Run the App
- ** Clone the repository**:
  ```bash
  git clone https://github.com/Dipanshu22/_Review_Video_Flutter_App.git
  cd review_video_app

  ```
- **Install dependencies**:
  ```bash
  flutter pub get
  ```
- **Run the app**:
  Ensure your emulator or physical device is connected, then run:
  ```bash
  flutter run
  ```
## Screenshots
- **Role Selection**
  
  - User chooses either "Director" or "Artist" on the home screen.

  ![Screenshot 2024-11-28 114858](https://github.com/user-attachments/assets/a6c6af08-7183-4876-a41e-37caede10eea)

- **Director View**
  - Director adds comments to the video at specific timestamps.
  - ![Screenshot 2024-11-28 115208](https://github.com/user-attachments/assets/a6f4e679-8cb4-472e-afe8-ad4b503026c6)
  - ![Screenshot 2024-11-28 115541](https://github.com/user-attachments/assets/ef54f3d0-739d-424a-8d70-7e1e28cc223d)



- **Artist View**
  - Artist replies to comments made by the Director.
   - ![Screenshot 2024-11-28 115649](https://github.com/user-attachments/assets/6940fc4c-6fc2-4649-bed5-f7ae8a46d73f)
   - ![Screenshot 2024-11-28 115826](https://github.com/user-attachments/assets/3e1b84ee-1b87-4de4-9d22-eadee6fe140f)



## Design Decisions

- **State Management**: The `provider` package was chosen for state management due to its simplicity and scalability.
- **Dynamic Layouts**: Portrait mode prioritizes fullscreen video playback for better viewing, while landscape mode combines video and comments for efficient multitasking.
- **Comment Timestamp Markers**: Added to enhance user navigation and link comments directly to specific moments in the video.

## Conclusion
The  Review Video Platform app provides a clean and interactive interface for video playback and user role-specific commenting functionality. With responsive layouts and advanced features like timestamp-based comments, it is ideal for video collaboration or review workflows.

Feel free to contribute, report issues, or suggest improvements by opening an issue or pull request on GitHub. Happy coding! 🚀

  
