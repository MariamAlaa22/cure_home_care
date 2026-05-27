# CureCare - Home Care Nursing Booking Module

A Flutter mobile application module built for booking and orchestrating home-care nursing services using standard architecture patterns and BLoC state management[cite: 1].

##  Project Structure & Architecture
The project is organized into feature-based folders (Auth, Booking) with a clear separation of concerns[cite: 1]:
* **Presentation Layer:** Contains responsive UI screens (`LoginScreen`, `SignupSteps`, `SelectServiceScreen`, `ScheduleVisitScreen`, `BookingSummaryScreen`, and `ProfileScreen`)[cite: 1].
* **Domain & Logic:** Business logic is managed locally using standard BLoC/Cubit state management to handle user interactions and sequential flows[cite: 1].
* **Data Layer:** Powered by a local mock data source (`auth_mock_data.dart`) to simulate functional user session tracking and state validation[cite: 1].

##  Implemented Features
1. **Identity & Session Management:** Dynamic user login and multi-step registration[cite: 1].
2. **Dynamic 3-Step Booking Flow:** Structured wizard for service selection, date/time scheduling, patient clinical remarks input, and final review confirmation[cite: 1].
3. **Patient Profile & Navigation:** Integrated bottom navigation layout with an editable clinical information card and direct links to sub-screens[cite: 1].
