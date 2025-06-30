# Fruti App - Food Delivery

A feature-rich food delivery application built with Flutter as part of a developer assessment. This project showcases a modern, animated, and functional user interface, complete with state management, custom animations, and a clean project structure.

## Key Features

-   **Splash Screen:** A smooth entry point with a `Hero` animation for the app logo.
-   **Authentication:** Functional Login and Sign-Up screens with an animated toggle, form validation, and a simulated loading state.
-   **Main Navigation Hub:** A persistent Bottom Navigation Bar with a custom animated indicator, managing four main screens using a `PageView`.
-   **Four Core Screens:**
    -   **Discover:** A screen for browsing categories and featured deals.
    -   **Market (Product List):** A scrollable list of restaurants with a functional search bar and an interactive location selector.
    -   **Community:** A social media-style feed displaying user posts.
    -   **Profile:** A user account page with settings and a functional log out button.
-   **Product Details:** A detailed view for each product with a slide-up page transition, filterable reviews, and an animated expand/collapse feature.
-   **Functional Shopping Cart:**
    -   State managed globally using the **Provider** package.
    -   Real-time cart badge updates across the app.
    -   A dedicated cart screen to manage quantities, remove items, or clear the cart.
-   **Rich Animations:** Staggered list animations, fade-ins, and custom page transitions create a fluid and engaging user experience.

## Getting Started

This project uses **FVM (Flutter Version Manager)** to ensure a consistent development environment.

### Prerequisites

*   You must have the [Flutter SDK](https://docs.flutter.dev/get-started/install) installed to get the `dart` command.
*   An editor like [VS Code](https://code.visualstudio.com/) or [Android Studio](https://developer.android.com/studio).
*   A connected device (physical or emulator).

### Installation & Running (FVM - Recommended)

1.  **Install FVM:**
    If you don't have FVM, install it globally:
    ```bash
    dart pub global activate fvm
    ```

2.  **Provision the Flutter SDK:**
    Navigate to the project root and run the following command. FVM will automatically download and set up the correct Flutter version for this project.
    ```bash
    fvm install
    ```

3.  **Install dependencies:**
    Use the FVM-prefixed command to get all the required packages.
    ```bash
    fvm flutter pub get
    ```

4.  **Run the application:**
    Use the FVM-prefixed command to run the app.
    ```bash
    fvm flutter run
    ```
    > **IDE Tip:** For a better experience in VS Code, this project includes a `.vscode/settings.json` file. It will automatically configure VS Code to use the correct FVM-managed SDK, so you can use the standard Run/Debug buttons.

### Running Without FVM

If you prefer not to use FVM, you must have a compatible version of Flutter installed globally (see `environment.sdk` in `pubspec.yaml`). Then, you can run the standard commands: `flutter pub get` and `flutter run`.

## Technical Overview & Dependencies

This project is built upon a specific set of tools and packages defined in the `pubspec.yaml` file.

### Flutter Version

This project is configured to run with Flutter SDK version **`^3.5.4`**.

The `^` symbol indicates that the project is compatible with any version from `3.5.4` up to (but not including) `4.0.0`. Running this project with a significantly older or newer major version of Flutter (e.g., Flutter 2.x or 4.x) may result in build errors or unexpected behavior.

### Key Packages Used

The following packages are crucial to the app's functionality:

*   **`google_fonts: ^6.2.1`**: Used for applying custom typography (specifically the Poppins font family) throughout the application for a consistent and clean look.
*   **`provider: ^6.1.5`**: The core of the app's state management. It is used to manage the global state of the shopping cart, allowing different screens to interact with the same data seamlessly.
*   **`flutter_staggered_animations: ^1.1.1`**: Implemented to create visually appealing staggered loading animations for all list views (e.g., product list, community feed), enhancing the user experience.
*   **`flutter_lints: ^4.0.0`**: A development dependency that provides a set of recommended lints to enforce good coding practices and maintain code quality.

### Assets

The project uses local assets for images and icons, which are located in the following directories:

*   `assets/icons/`
*   `assets/images/`

These assets are declared in the `pubspec.yaml` and bundled with the application.

## Project Overview & Design Choices

### State Management

-   **Provider Package:** The `provider` package was used for managing app-wide state, specifically for the `CartProvider`. This choice is efficient, scalable, and officially recommended for sharing state that multiple screens need to access (like the cart total and item list).
-   **`StatefulWidget` & `setState`:** For state that is local to a single screen (e.g., the search query, selected filters, or loading indicators), the standard `StatefulWidget` was used to keep the logic simple and contained.

### Navigation

-   **Main Navigation Shell:** The app uses a `MainScreen` widget which contains the `BottomNavigationBar` and a `PageView`. This is a robust architectural pattern that preserves the state of each of the four main screens as the user navigates between them.
-   **Named Routes:** All navigation is handled via named routes defined in `lib/utils/app_routes.dart` for clean, decoupled code.
-   **Custom Transitions:** `PageRouteBuilder` is used to create custom animations for page transitions, such as the slide-up effect for the Product Detail screen.

### Data Source

-   The application operates on **mock data** stored in local files within the `lib/data/` directory. This was done to simulate a backend API and fully populate the UI for a complete demonstration without requiring a network connection.

### Project Structure

The project follows a clean, feature-oriented structure to ensure code is organized and easy to maintain.

lib/
├── data/ # Mock data files
├── models/ # Data models (Product, CartItem, etc.)
├── providers/ # State management (CartProvider)
├── screens/ # All major screens of the app
├── utils/ # Utility files (colors, routes)
└── widgets/ # Reusable UI components (CustomButton, CartBadge, etc.)

### Authentication

The login and sign-up process is **simulated**. The form includes full validation for all fields, but the `_submitForm` function uses a `Future.delayed` to mimic a network call before navigating the user to the main app. No actual user accounts are created or stored. This approach allows for a complete demonstration of the authentication UI and user flow without requiring a backend service.

### Animation and User Experience

A strong emphasis was placed on creating a fluid and responsive user experience. A variety of animation techniques were employed to achieve this:

*   **`Hero` animation:** Used for the seamless logo transition from the splash screen to its final position on the login screen.
*   **Implicit Animations (`AnimatedContainer`, `AnimatedAlign`, `AnimatedOpacity`):** These were used for simple, state-driven UI changes like the sliding login toggle and the fade-in effect of the login form elements.
*   **`flutter_staggered_animations` package:** This package creates the visually appealing staggered loading effect for all list views, making the content appear dynamically.
*   **`PageRouteBuilder`:** This was used to create custom full-page transitions, specifically the "slide-up" animation for the Product Detail screen, providing a more modern feel than the default page route.