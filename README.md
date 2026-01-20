# GitHub User App – Flutter

A Flutter application that consumes the GitHub REST API to display GitHub users, supports pagination, user detail view, and local favorite management using Bloc state management and SQLite.

This project was developed as part of a **technical skill test for the IT Mobile Programmer position**.

---

## ✨ Features

- Fetch GitHub users from public GitHub API
- Pagination (load 20 users per request)
- View detailed GitHub user profile
- Add / remove users from favorites
- Local favorite persistence using SQLite
- Separate Bloc for:
  - GitHub user list
  - Favorite user list
  - Favorite status (real-time UI update)
- Clean architecture (UI → Bloc → Repository → Data Source)
- Loading spinner handled at Bloc level (not UI)

---

## 🛠️ Tech Stack

- **Flutter**
- **Bloc (flutter_bloc)**
- **GitHub REST API**
- **SQLite (sqflite)**
- **Clean Architecture principles**

---

## 🔐 Environment Setup (IMPORTANT)

This application uses a **GitHub Personal Access Token** to avoid API rate limits.

### 1️⃣ Create `.env` file

After cloning the repository, create a file named `.env` in the root project directory:

### 2️⃣ Fill `.env` with your GitHub token

GITHUB_TOKEN=YOUR_GITHUB_TOKEN_HERE

> ⚠️ Make sure to use **your own token**  
> The token **must NOT be committed** to the repository.

---

## 🔑 How to Create GitHub Token

1. Go to https://github.com/settings/tokens
2. Click **Generate new token**
3. Select:
   - `public_repo` (minimum required)
4. Copy the token and paste it into `.env`

---

## 🚀 How to Run the App

```bash
# Get dependencies
flutter pub get

# Run app
flutter run

# Build Apk
flutter build apk --release

## The APK file will be generated at:
build/app/outputs/flutter-apk/app-release.apk

