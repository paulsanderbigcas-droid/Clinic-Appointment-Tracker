# Clinic-Appointment-Tracker

This project is a console-based Dart application that simulates a clinic appointment and billing system where users can register patients, view medical records, and process consultation payments. It demonstrates core Object-Oriented Programming principles like inheritance, abstract classes, and mixins, while utilizing asynchronous functions to simulate realistic network loading delays when connecting to the hospital database.

## Features & Implementation
- **Object-Oriented Programming (OOP)**:
  - **Base Class**: `User`
  - **Subclass**: `Patient` (demonstrates inheritance and custom constructors)
  - **Abstract Interface**: `Reportable` (enforces consultation reporting)
  - **Mixin**: `LoggerMixin` (reusable timestamped logging functionality)
- **Asynchronous Operations**: Uses `Future`, `async`, and `await` to simulate database connectivity and loading delays.
- **Error Handling**: Implements `try-catch` blocks and null-safety operators (`??`) to handle console inputs safely.

## How to Run
1. Ensure the Dart SDK is installed on your system.
2. Open your terminal in the project directory.
3. Run the application using:
   ```bash
   dart run main.dart
