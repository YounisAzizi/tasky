# Flutter Todo Application

## Overview

This Flutter project is a comprehensive Todo application that includes robust authentication, phone number validation, JWT-based authorization, and a fully functional Todos list with various states and features. It also incorporates QR code generation and scanning, camera integration for image uploads, and responsive design for optimal usability across all devices.

## Features

1. **Authentication**
   - Phone Number and Password: Users can sign up and log in using their phone number and password.
   - Phone Number Validation: The app validates phone numbers based on the user's country.

2. **Authorization**
   - JWT Token: Authorization is handled using JWT tokens.
   - Refresh Tokens: The app handles token refreshing automatically:
      - 401: Not authorized, need to refresh the token.
      - 403: Refresh failed.
      - 200: Refresh successfully.

3. **Todos List**
   - Loading State: Shows a loading indicator while fetching data.
   - Empty State: Displays a message when there are no todos.
   - Error State: Shows an error message if fetching data fails.
   - Refresher: Allows users to refresh the list manually.
   - Infinite Scroll: Loads more todos as the user scrolls down.

4. **Responsive Design**
   - The app is designed to be responsive, ensuring a good user experience on all screen sizes.

5. **QR Code Features**
   - QR Generation: Generates a QR code for each todo item based on its ID.
   - QR Scanner: Allows users to scan QR codes to open task details directly.

6. **Camera Integration**
   - Image Upload: Users can add images to their todos using their device's camera or gallery.

## APIs Used

   - Register: [https://todo.iraqsapp.com/auth/register](https://todo.iraqsapp.com/auth/register)
   - Login: [https://todo.iraqsapp.com/auth/login](https://todo.iraqsapp.com/auth/login)
   - Get Todos: [https://todo.iraqsapp.com/todos?page=1](https://todo.iraqsapp.com/todos?page=1)
   - Other APIs: Various other APIs are used for different functionalities.

## State Management

   - Riverpod: The app uses Riverpod for state management, ensuring a reactive and efficient state management solution.

## Getting Started

### Prerequisites

   - Flutter SDK
   - Dart SDK
   - A code editor (e.g., Android Studio, Visual Studio Code, IntelliJ IDEA)

### Installation

   - Clone the repository:
     ```sh
     git clone https://github.com/YounisAzizi/tasky.git
     cd tasky
     ```
   - Install dependencies:
     ```sh
     flutter pub get
     ```
   - Run the app:
     ```sh
     flutter run
     ```

### Configuration

   - API Endpoints: Update the API endpoints in the Apis class as necessary.
   - JWT Token Handling: Ensure the JWT token and refresh token handling logic is correctly implemented in the AuthServices class.

## Usage

   - Sign Up: Register a new user using the phone number and password.
   - Log In: Log in with the registered phone number and password.
   - Manage Todos: Add, edit, delete, and view todos. Use the camera to upload images and scan QR codes to view todo details.
   - Responsive Design: Use the app on different devices to experience the responsive design.

## Contributing

   - Fork the repository.
   - Create a new branch (`git checkout -b feature/your-feature`).
   - Commit your changes (`git commit -m 'Add some feature'`).
   - Push to the branch (`git push origin feature/your-feature`).
   - Open a pull request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

Enjoy using the Flutter Todo Application! If you have any questions or need further assistance, please feel free to [contact us](mailto:your-email@example.com).
