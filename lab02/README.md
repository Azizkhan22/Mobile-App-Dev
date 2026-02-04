# Flutter Navigation App

A comprehensive Flutter application demonstrating feature-based folder structure and navigation using named routes.

## 📁 Project Structure

```
lib/
├── main.dart                          # Application entry point
├── app.dart                           # Root widget with MaterialApp configuration
├── routes/
│   └── app_routes.dart               # Centralized routing configuration
├── features/
│   ├── auth/
│   │   └── screens/
│   │       └── login_screen.dart     # Login screen with validation
│   ├── home/
│   │   └── screens/
│   │       └── home_screen.dart      # Home screen with quick actions
│   └── profile/
│       └── screens/
│           └── profile_screen.dart   # Profile screen (Extra Feature)
└── core/
    ├── widgets/                       # Reusable widgets (future)
    └── constants/                     # App constants (future)
```

## ✨ Features Implemented

### Task 2: Feature-Based Folder Structure 
- Organized code by features (auth, home, profile)
- Separated screens, widgets, and routes
- Scalable and maintainable architecture

### Task 3: Application Entry Point Configuration 
- **app.dart**: Root application widget with MaterialApp configuration
  - Debug banner disabled
  - Application title set
  - Initial route defined
  - Named routes registered
- **main.dart**: Calls the root application widget

### Task 4: Navigation Using Routes
- **app_routes.dart**: Centralized routing file
- Named routes for:
  - Login screen (`/`)
  - Home screen (`/home`)
  - Profile screen (`/profile`)
- Navigation implemented using `Navigator.pushNamed()`

### Task 5: UI Screens

#### Login Screen
- Beautiful gradient background
- Form validation for email and password
- Password visibility toggle
- Responsive design with cards and shadows
- Navigate to Home Screen on successful login

#### Home Screen
- Welcome card with gradient
- Quick action grid with 4 features
- Navigation to Profile screen
- Logout functionality
- Material Design 3

#### Profile Screen (Extra Feature) 
- User profile display
- Account information cards
- Action buttons (Edit, Change Password, Delete)
- Confirmation dialogs

## 📱 Screens Flow

```
Login Screen (/)
    ↓ [Login Button]
Home Screen (/home)
    ↓ [Profile Card]
Profile Screen (/profile)
    ↓ [Back Button]
Home Screen
    ↓ [Logout Button]
Login Screen (/)
```

## 🎯 Navigation Methods Used

1. **Navigator.pushNamed()**: Navigate to a named route
   ```dart
   Navigator.pushNamed(context, AppRoutes.home);
   ```

2. **Navigator.pushNamedAndRemoveUntil()**: Navigate and clear back stack
   ```dart
   Navigator.pushNamedAndRemoveUntil(
     context,
     AppRoutes.login,
     (route) => false,
   );
   ```

3. **Navigator.pop()**: Go back to previous screen
   ```dart
   Navigator.pop(context);
   ```
