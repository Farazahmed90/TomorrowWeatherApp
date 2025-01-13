# TomorrowWeatherApp

TomorrowWeatherApp is a Swift-based iOS application that provides weather forecasts for multiple locations using real-time data. The app is built using the MVVM (Model-View-ViewModel) architecture and integrates with open-meteo weather API to fetch and display weather information.

## Features

- **Real-Time Weather Updates**: Displays weather information such as temperature, location, and hourly forecasts for predefined coordinates.
- **Rotating Locations**: Automatically cycles through a list of preset locations every 10 seconds to showcase weather conditions for each.
- **Chart Representation**: Visualizes temperature variations using SwiftUI Charts.
- **Background & Foreground Handling**: Saves the app's state when backgrounded and resumes seamlessly when reopened.
- **Testable Architecture**: Includes mocks and unit tests to ensure the accuracy of weather service and app logic.

## Directory Structure

TomorrowWeatherApp/
├── HomeScreen/
│   ├── Views/
│       ├── InfoCard
│       ├── TemperatureChartView
│       ├── WeatherInfoView
│       ├── WeatherView
│       ├── WeatherViewModel
├── Model/
│   ├── WeatherModel
├── Network/
│   ├── Constants
│   ├── URLSession
├── Service/
│   ├── WeatherService
├── Preview Content/
│   ├── Preview Assets
├── Tests/
│   ├── WeatherServiceMock
│   ├── WeatherServiceTests
│   ├── TomorrowWeatherAppUITests

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/Farazahmed90/TomorrowWeatherApp.git
   cd TomorrowWeatherApp
2. open TomorrowWeatherApp.xcodeproj
3. Build and run the project on a simulator or device.

## Usage
Launch the app.
View real-time weather updates for a rotating list of locations.
Navigate through the visual temperature charts and detailed weather data.

## Testing
The app includes unit tests and UI tests. Run the tests in Xcode by navigating to:
Product → Test or using the shortcut Command + U.

## Technologies Used
Swift: Programming language
SwiftUI: User interface framework
Combine: Framework for handling asynchronous events
XCTest: Testing framework

## Improvements or Features to Add If this were not a test exercise, the following features or enhancements could be considered:
- **Custom Location Input: Allow users to add their own coordinates or select a location via a map interface.
- **Caching: Implement local caching for weather data to reduce API calls and enhance offline usability.
- **Localization: Add support for multiple languages and regional formats for temperature and time.
- **Error Handling: Improve user-facing error messages and provide a retry mechanism for network failures.
- **Dark Mode: Enhance UI with proper support for dark mode.
- **Settings Page: Let users configure the update interval, temperature units (Celsius/Fahrenheit), and location preferences.
- **Push Notifications: Notify users of severe weather updates or significant temperature changes.
- **Widget Support: Add home screen widgets to display quick weather updates.
- **Improved UI: Add animations, transitions, and a cleaner layout for a more polished user experience.
- **API Abstraction: Generalize the weather service to allow switching between multiple APIs

