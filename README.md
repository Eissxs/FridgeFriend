# **FridgeFriend v1.0**

![Swift](https://img.shields.io/badge/Swift-5.0%2B-orange)
![Platform](https://img.shields.io/badge/Platform-iOS%2017.0%2B-blue)
![License](https://img.shields.io/badge/License-Apache--2.0-green)
![Status](https://img.shields.io/badge/Status-Prototype-yellow)

*ITEL315 – Elective iOS Development*

FridgeFriend is an iOS app built with SwiftUI that helps you manage your food inventory, reduce waste, and make the most of your groceries. With features like expiry tracking, leftover management, and recipe suggestions, FridgeFriend makes kitchen organization effortless.

> **Note:** This is a **prototype-level project** developed for learning SwiftUI, exploring OCR features, and building functional offline-first file organization workflows.

## **Key Features**

- **Smart Inventory Management**
  - Track food items with expiry dates
  - Mark and monitor leftovers
  - Visual expiry status indicators
  - Undo support for deleted items

- **Grocery List**
  - Easy item addition and management
  - Move items directly to inventory
  - Customizable quantities and notes
  - Organized shopping experience

- **Voice & Photo Integration**
  - Voice input for quick item addition
  - Photo recognition for product details
  - OCR-powered text extraction
  - Speech recognition support

- **Recipe Suggestions**
  - Smart recipe recommendations based on inventory
  - Basic recipe collection included
  - Easy-to-follow instructions
  - Ingredient-based matching

- **User Experience**
  - Clean, modern SwiftUI interface
  - Haptic feedback
  - Smooth animations
  - Intuitive gestures
  - Dark mode support

## **Tech Stack**

- **Framework:** SwiftUI
- **Data Persistence:** CoreData
- **Image Processing:** Vision Framework
- **Voice Recognition:** Speech Framework
- **Local Notifications:** UserNotifications
- **Design:** SF Symbols, Custom Color Palette

## **App Screenshots**

<div align="center">
  <img src="https://github.com/user-attachments/assets/2a6a0fca-bdf3-4881-87ab-34dcc4d06059" width="45%" />
  <img src="https://github.com/user-attachments/assets/6a0553ea-c28a-4448-b6ef-dca513fe63f5" width="45%" />
</div>
<br/>
<div align="center">
  <img src="https://github.com/user-attachments/assets/e318115f-d71c-4d31-96bc-68fc32b5d567" width="45%" />
  <img src="https://github.com/user-attachments/assets/9126dd1e-c3bb-48a3-b577-35c499fc83af" width="45%" />
</div>
<br/>
<div align="center">
  <img src="https://github.com/user-attachments/assets/d22ef5ad-f9c1-4581-a1a1-bc471008ed4d" width="45%" />
  <img src="https://github.com/user-attachments/assets/18b2e1cb-735c-4ee6-a544-e7376fefd021" width="45%" />
</div>

## **Project Structure**

```
FridgeFriend/
├── Views/
│   ├── DashboardView.swift
│   ├── InventoryView.swift
│   ├── GroceryListView.swift
│   ├── AddItemView.swift
│   └── RecipeSuggestionsView.swift
├── Models/
│   └── Recipe.swift
├── ViewModels/
│   └── InventoryViewModel.swift
├── Utilities/
├── FridgeFriend.xcdatamodeld/
└── Assets.xcassets/
```

## **Requirements**

- iOS 17.0+
- Xcode 15.0+
- Swift 5.0+

## **Installation**

1. Clone the repository:
   ```bash
   git clone https://github.com/Eissxs/FridgeFriend.git
   ```

2. Open `FridgeFriend.xcodeproj` in Xcode

3. Build and run the project

## **Features in Detail**

### Inventory Management
- Add items with expiry dates
- Track leftover status
- Visual expiry indicators
- Undo delete operations
- Sort by expiry date

### Grocery List
- Quick item addition
- Transfer to inventory
- Custom notes and quantities
- Organized shopping experience

### Smart Features
- Voice input support
- Photo recognition
- OCR text extraction
- Recipe suggestions

## **Privacy Permissions**

The app requires the following permissions:
- Camera (for scanning items)
- Photo Library (for importing food images)
- Microphone (for voice input)
- Speech Recognition (for voice commands)

## **Contributing**

Feel free to submit issues and enhancement requests!

## **License**

This project is licensed under the Apache License 2.0 - see the [LICENSE](LICENSE) file for details.

## **Documentation**

- [**UI Flow Diagram**](docs/UI_Flow_Diagram.png) *(Note: Created using Eraser AI; not fully accurate)*  
- [**Architecture Overview**](docs/Architecture_Overview.png)  
- [**Developer Setup Guide**](docs/DEV_SETUP.md)

## **Areas for Improvement (Toward Production Readiness)**

### Architecture & Code Quality
- Implement comprehensive unit tests and UI tests
- Add CI/CD pipeline for automated testing and deployment
- Enhance error handling and logging mechanisms
- Implement proper dependency injection
- Add comprehensive code documentation

### Security
- Implement secure data storage for sensitive information
- Add input validation and sanitization
- Implement proper SSL pinning for future API integrations
- Add app state encryption for sensitive data

### Performance
- Optimize image processing pipeline
- Implement proper caching mechanisms
- Add performance monitoring and analytics
- Optimize CoreData queries and indexing

### Features & UX
- Add data backup and restore functionality
- Implement user accounts and sync capabilities
- Add barcode scanning for product identification
- Enhance accessibility features
- Add localization support for multiple languages
- Implement advanced recipe recommendation algorithm

### Infrastructure
- Set up proper monitoring and crash reporting
- Implement analytics for user behavior tracking
- Add proper versioning and update mechanism
- Prepare for App Store submission requirements

## **Author**

Developed by **Eissxs** 

## **Acknowledgments**

- Apple SwiftUI Framework
- Vision Framework
- Speech Recognition Framework
- CoreData

---

*"Keep your fridge organized, reduce waste, and cook smarter with FridgeFriend!"* 

---
