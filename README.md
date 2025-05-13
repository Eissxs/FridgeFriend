# **PaperMind v1.0 (Prototype)**  
*ITEL315 – Elective iOS Development*

**PaperMind** is a minimalist iOS app prototype built with **SwiftUI** to help users digitize and organize physical documents using OCR and automatic categorization. Users can scan or import papers, extract text with OCR, and let the app sort them into folders like Urgent, Later, and Trash—all stored locally with a clean, playful interface.

> **Note:** This is a **prototype-level project** developed for learning SwiftUI, exploring OCR features, and building functional offline-first file organization workflows.

---

## **Key Features**

- **Scan & Import:** Capture documents via camera or import from photo library  
- **OCR-Powered Sorting:** Extracts key text using Vision OCR  
- **Smart Categorization:** Automatically places documents into folders (Urgent, Later, Trash)  
- **Tap-to-Zoom Preview:** View documents fullscreen with text overlay  
- **Swipe Actions:** Reassign or delete documents with visual feedback  
- **Haptics & Animation:** Feedback via Core Haptics and custom transitions  
- **Local Storage:** Documents and categories persist using `UserDefaults`  
- **Splash Screen:** Animated entry with logo scaling  
- **Daily Scan Reminder:** Local notification to prompt regular use  
- **Zen UI:** Color-coded folders, animated background, and minimalist layout  

---

## **Tech Stack**

- **Swift / SwiftUI**  
- **VisionKit / Vision Framework** – OCR and image processing  
- **UserNotifications** – Daily local notifications  
- **UserDefaults** – For document persistence  
- **Core Haptics** – Haptic feedback on interactions  
- **SF Symbols** – Icon-based category visuals  

---

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

---

## **Project Objectives**

This prototype demonstrates:

- OCR integration in a native iOS app  
- Real-time scan + sort flow using MVVM  
- Local-only document storage with persistent state  
- Building delightful micro-interactions (haptics, animation)  
- Designing an intuitive scanning interface in SwiftUI  

---

## **Installation Instructions**

1. Clone the repository:  
   ```bash
   git clone https://github.com/Eissxs/PaperMind.git
   ```
2. Open `PaperMind.xcodeproj` in Xcode  
3. Run on a simulator or physical iOS device (**iOS 17+ recommended**)

---

## **Areas for Improvement (Toward Production Readiness)**

### 1. **File Organization**

- Some logic still resides in primary views  
- **Recommended structure:** `Models/`, `ViewModels/`, `Views/`, `Resources/`  
- Extract reusable components (e.g., document preview, category buttons)

### 2. **State Management**

- Currently uses `@State` and `@Binding`  
- Use `ObservableObject` and `@StateObject` for improved modularity and testability

### 3. **Data Persistence**

- `UserDefaults` is suitable for lightweight prototyping  
- For scalability, consider `CoreData`, `FileManager`, or `SQLite`

### 4. **OCR + AI Enhancements**

- Enhance categorization with NLP (e.g., keyword tagging)  
- Add feedback loop to improve sorting accuracy over time

### 5. **Strings & Localization**

- Move hardcoded strings to `Localizable.strings` or a centralized `Constants.swift` file  
- Enables localization and reduces redundancy

---

## **Daily Reminder Setup**

- Sends one local notification daily to prompt scanning  
- Triggered using `UNUserNotificationCenter`  
- Requires notification permissions on first app launch  
- Fully local — no server or cloud integration

---

## **Documentation**

- [**UI Flow Diagram**](docs/UI_Flow_Diagram.png) *(Note: Created using Eraser AI; not fully accurate)*  
- [**Architecture Overview**](docs/Architecture_Overview.png)  
- [**Developer Setup Guide**](docs/DEV_SETUP.md)

---

## **Author**

Developed by **Eissxs**  
*“When I wrote this code, only God and I understood what I did. Welp, now only God knows.”*
