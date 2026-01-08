# Der Kleine Freitag

## Local Configuration (Important)

To prevent leaking sensitive information like Apple Development Team IDs to GitHub, this project uses a local configuration file. 

Before building, create a file named `Secrets.xcconfig` in the root directory:

```xcconfig
// Secrets.xcconfig
DEVELOPMENT_TEAM = YOUR_TEAM_ID_HERE
```

This file is ignored by git and allows you to use your own provisioning profiles without modifying the tracked project files.

**Der Kleine Freitag** is an iOS application and Widget that brings a bit of fun to your weekly routine by renaming standard weekdays with culturally localized nicknames.

## Overview

Why call it "Thursday" when it's clearly "der kleine Freitag" (the little Friday)? This project provides a simple yet delightful widget for your iOS Home and Lock Screen that displays the current day with a twist.

## Features

- **Fun Weekday Names:** automatically replaces standard names with custom terms.
  - *Thursday* -> "der kleine Freitag"
  - *Wednesday* -> "Bergfest" (Mountain Feast / Hump Day)
- **Widget Support:**
  - **System Small:** Perfect for a quick glance.
  - **Lock Screen:** Inline, Circular, and Rectangular widgets supported.
- **Data-Driven Logic:** Powered by the internal `DerKleineFreitagKit` framework.
- **Localization:** Fully localized in German and English.

## Project Structure

- **DerKleineFreitag:** Main iOS App containing the preview UI.
- **DerKleineFreitagWidget:** The Widget Extension handling the timeline and views.
- **DerKleineFreitagKit:** A reusable Swift Package containing the `CustomWeekDayFormatter` logic and localized strings.

## Installation

1.  Clone the repository.
2.  Open `DerKleineFreitag.xcodeproj` in Xcode.
3.  Ensure the `DerKleineFreitagKit` package is correctly linked (if using a local package workflow).
4.  Build and run on your iPhone or Simulator.
5.  Add the widget to your Home Screen.

## Requirements

- iOS 16.0+
- Xcode 15.0+
- Swift 5.9+

## License

This project is licensed under the MIT License.
