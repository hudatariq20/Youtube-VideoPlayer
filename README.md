# Youtube Player

### Project Overview

his project is a Flutter-based mobile application that mimics the **"YouTube Shorts"** experience, allowing users to vertically swipe through a feed of short-form videos. The app demonstrates modern Flutter development practices, integration with video streaming APIs, and a clean, responsive UI.

### 🚀 Features

* **Vertical Video Feed**: Users can swipe up and down to browse through a list of short videos, similar to YouTube Shorts or TikTok.
* **Video Streaming**: Videos are streamed from Mux using their API, with each video’s metadata and playback information fetched dynamically.
* **Progress Indicator**: Each video displays a progress bar at the bottom, showing how much of the video has played.
* **Custom Navigation Bar**: A bottom navigation bar allows for easy navigation within the app.
* **Modern UI**: Uses Material Design, Google Fonts, and Flex Color Scheme for a polished look.
* **Asset and Network Support**: The app can be configured to play videos from local assets or from the network (Mux).

## 🎨 Demo Link
Here is a demo of the application in action:
[Watch the video]
https://drive.google.com/file/d/1g6Nw1OvL8Y_V-pwfc5se8e84vJnXajjr/view?usp=drive_link

## 🛠️ Technical Highlights
* **State Management**: Uses StatefulWidget and PageController for managing video feed and playback.
* **Video Playback**: Utilizes the video_player package for smooth video playback.
* **API Integration**: Fetches video metadata and streaming URLs from the Mux API using secure credentials.
* **Environment Variables**: Sensitive API keys are managed using the envied package.
* **Code Generation**: Uses build_runner for generating environment and model files.
* **Cross-Platform**: Runs on both Android and iOS, with platform-specific permissions handled.

## Contributions
Contributions are welcome! Please fork the repository and create a pull request with your enhancements or fixes.

## Contact
For any inquiries or issues, please contact huda.tariq94@gmail.com



