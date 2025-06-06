## Introduction
As more and more people are using the Internet, a new trend emerged: doom scrolling. 
This often happens because of short attention spans and need for constant stimulation. 
I’ve experienced this myself, and I thought, wouldn’t it be perfect to have a doom scroller, but for A Level Students?

## The Must-Have Features
- [ ] User Authentication: Users can sign up and log in to the app with their profiles
- [ ] Doom Scrolling: The main part of the app, where instead of videos, you scroll through A Level questions
- [ ] Feed Customization: Users can choose their subjects, topics and papers -> e.g. “Chemistry, Equilibrium, Paper 1”
- [ ] AI Question Marker: An AI that marks questions involving more complex answers, such as structure questions, etc.
- [ ] Reward System: Earn points for questions answered
- [ ] Questions Saver: Save questions to a list for later
- [ ] AI Algorithm: An algorithm that gets your weakest topics and put them in your feed
- [ ] Leaderboard: A leaderboard that shows the top scorers of the app
- [ ] AI Study Techniques Integration: Applies spaced repetition and other techniques to the questions in the feed
- [ ] Intuitive UI: Similar to apps in the market, users know how to use it immediately

## Not Important, But Future Features
- [ ] Support for other exam boards, such as Edexcel…

## Current Challenges
- [ ] AI Algorithms: Creating an AI that perform the aforementioned tasks is complex.
- [ ] Cost: The cost of running AIs might skyrocket.
- [ ] Question Bank: Creating a question bank by extracting from past papers is tedious but hard to automate.

<br>
## For Developers - Folder Structure
```
lib/
├── main.dart                                  // Application entry point
|
├── core/                                      // Core functionalities, utilities, constants, themes
│   ├── constants/
│   │   ├── constants.dart                     // Global app-level constants (e.g., app name, default values)
│   │   └── api_endpoints.dart                 // Defines all API endpoints (e.g., for AI marking service)
│   ├── errors/
│   │   ├── failures.dart                      // Defines custom Failure classes (e.g., AuthFailure, NetworkFailure)
│   │   └── exceptions.dart                    // Defines custom Exception classes (e.g., ServerException, CacheException)
│   ├── utils/
│   │   ├── app_utils.dart                     // General utility functions (e.g., date formatting, string manipulation)
│   │   ├── validation_utils.dart              // Helper functions for input validation
│   │   └── logger.dart                        // A simple logging utility
│   ├── routes/
│   │   ├── app_router.dart                    // Manages all named routes and navigation logic
│   │   └── route_names.dart                   // Defines string constants for all app's routes
│   └── theme/
│       ├── app_theme.dart                     // Defines the overall theme data for your app
│       ├── colors.dart                        // Defines a palette of custom colors
│       └── text_styles.dart                   // Defines specific text styles for various UI elements
|
├── data/                                      // Data layer: models, data sources, repository implementations
│   ├── models/                                // Data models for serialization/deserialization with external sources
│   │   ├── user_model.dart
│   │   ├── question_model.dart
│   │   ├── subject_model.dart
│   │   ├── topic_model.dart
│   │   ├── leaderboard_entry_model.dart
│   │   ├── saved_question_model.dart
│   │   └── performance_data_model.dart
│   ├── datasources/                           // Abstract interfaces and their concrete implementations for data sources
│   │   ├── auth_remote_datasource.dart        // Handles user authentication (e.g., Firebase Auth)
│   │   ├── question_remote_datasource.dart    // Interacts with Firestore for questions
│   │   ├── leaderboard_remote_datasource.dart // Fetches data for the leaderboard
│   │   ├── ai_remote_datasource.dart          // Makes API calls to your AI marking service
│   │   └── user_remote_datasource.dart        // Manages user profile data and preferences in Firestore
│   └── repositories_impl/                     // Concrete implementations of domain-layer repository interfaces
│       ├── auth_repository_impl.dart
│       ├── question_repository_impl.dart
│       ├── leaderboard_repository_impl.dart
│       ├── ai_repository_impl.dart
│       └── user_repository_impl.dart
|
├── domain/                                    // Domain layer: core business logic (entities, repository interfaces, use cases)
│   ├── entities/                              // Plain Dart objects representing core data structures
│   │   ├── user_entity.dart
│   │   ├── question_entity.dart
│   │   ├── subject_entity.dart
│   │   ├── topic_entity.dart
│   │   ├── leaderboard_entry_entity.dart
│   │   ├── saved_question_entity.dart
│   │   └── performance_data_entity.dart
│   ├── repositories/                          // Abstract interfaces defining data operation contracts
│   │   ├── auth_repository.dart
│   │   ├── question_repository.dart
│   │   ├── leaderboard_repository.dart
│   │   ├── ai_repository.dart
│   │   └── user_repository.dart
│   └── usecases/                              // Classes encapsulating single pieces of business logic
│       ├── auth/
│       │   ├── sign_up.dart
│       │   ├── sign_in.dart
│       │   ├── get_current_user.dart
│       │   └── sign_out.dart
│       ├── questions/
│       │   ├── get_feed_questions.dart
│       │   ├── submit_answer.dart
│       │   ├── save_question.dart
│       │   ├── get_saved_questions.dart
│       │   └── delete_saved_question.dart
│       ├── feed_customization/
│       │   ├── update_feed_preferences.dart
│       │   └── get_feed_preferences.dart
│       ├── ai_marking/
│       │   └── mark_question.dart
│       ├── rewards/
│       │   ├── add_points.dart
│       │   └── get_user_points.dart
│       ├── leaderboard/
│       │   └── get_leaderboard.dart
│       ├── ai_algorithm/
│       │   ├── get_weakest_topics.dart
│       │   └── update_topic_performance.dart
│       └── study_techniques/
│           └── apply_spaced_repetition.dart
|
└── presentation/                              // Presentation layer: UI, state management (BLoC), widgets
    ├── auth/                                  // User Authentication feature
    │   ├── bloc/
    │   │   ├── auth_bloc.dart
    │   │   ├── auth_event.dart
    │   │   └── auth_state.dart
    │   ├── pages/
    │   │   ├── login_page.dart
    │   │   └── signup_page.dart
    │   └── widgets/
    │       └── auth_form_fields.dart
    │
    ├── question_feed/                         // Doom Scrolling (A-Level Questions) feature
    │   ├── bloc/
    │   │   ├── feed_bloc.dart
    │   │   ├── feed_event.dart
    │   │   └── feed_state.dart
    │   ├── pages/
    │   │   └── feed_page.dart
    │   └── widgets/
    │       ├── question_card.dart
    │       └── answer_input_widget.dart
    │
    ├── feed_customization/                    // Feed Customization feature
    │   ├── bloc/
    │   │   ├── feed_settings_bloc.dart
    │   │   ├── feed_settings_event.dart
    │   │   └── feed_settings_state.dart
    │   ├── pages/
    │   │   └── feed_settings_page.dart
    │   └── widgets/
    │       └── subject_topic_selector.dart
    │
    ├── ai_marking/                            // AI Question Marker feature
    │   ├── bloc/
    │   │   ├── ai_marker_bloc.dart
    │   │   ├── ai_marker_event.dart
    │   │   └── ai_marker_state.dart
    │   └── widgets/
    │       ├── ai_marker_display.dart
    │       └── feedback_dialog.dart
    │
    ├── rewards/                               // Reward System feature
    │   ├── bloc/
    │   │   ├── reward_bloc.dart
    │   │   ├── reward_event.dart
    │   │   └── reward_state.dart
    │   └── widgets/
    │       ├── points_display.dart
    │       └── reward_animation_widget.dart
    │
    ├── question_saver/                        // Questions Saver feature
    │   ├── bloc/
    │   │   ├── saved_questions_bloc.dart
    │   │   ├── saved_questions_event.dart
    │   │   └── saved_questions_state.dart
    │   ├── pages/
    │   │   └── saved_questions_page.dart
    │   └── widgets/
    │       └── saved_question_list_item.dart
    │
    ├── leaderboard/                           // Leaderboard feature
    │   ├── bloc/
    │   │   ├── leaderboard_bloc.dart
    │   │   ├── leaderboard_event.dart
    │   │   └── leaderboard_state.dart
    │   ├── pages/
    │   │   └── leaderboard_page.dart
    │   └── widgets/
    │       └── leaderboard_list_item.dart
    │
    ├── profile/                               // User Profile and settings (Weakest Topics, AI Study Techniques display)
    │   ├── bloc/
    │   │   ├── profile_bloc.dart
    │   │   ├── profile_event.dart
    │   │   └── profile_state.dart
    │   ├── pages/
    │   │   └── profile_page.dart
    │   └── widgets/
    │       ├── user_details_card.dart
    │       └── weakest_topics_chart.dart
    │
    ├── home/                                  // Main navigation/scaffold for the app
    │   ├── bloc/                              // Optional: for managing bottom nav state or global home state
    │   │   ├── home_navigation_bloc.dart
    │   │   ├── home_navigation_event.dart
    │   │   └── home_navigation_state.dart
    │   ├── pages/
    │   │   └── home_page.dart                 // Contains the main navigation (e.g., BottomNavigationBar)
    │   └── widgets/
    │       └── bottom_nav_bar.dart
    │
    └── shared_widgets/                        // Reusable UI components used across multiple features
        ├── custom_app_bar.dart
        ├── loading_indicator.dart
        ├── error_display.dart
        ├── custom_button.dart
        └── message_box.dart                   // Custom dialog for messages
```