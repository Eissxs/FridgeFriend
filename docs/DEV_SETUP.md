# FridgeFriend Developer Setup Guide

## Project Context
This is an ITEL315 iOS Development course project, built with professional development practices in mind. While it's a learning project, I've tried to incorporate industry-standard practices where possible.

## Quick Start

### Prerequisites
- Xcode 15.0+
- iOS 17.0 SDK
- macOS Sonoma 14.0+ (recommended)
- Git
- Swift 5.0+

### Getting Started

1. **Clone & Setup**
```bash
# Clone the repo
git clone https://github.com/Eissxs/FridgeFriend.git
cd FridgeFriend

# Open in Xcode
open FridgeFriend.xcodeproj
```

2. **First Build**
- Select your development team in Xcode
- Update bundle identifier if needed
- Build (⌘B) and run (⌘R)

## Project Structure

```
FridgeFriend/
├── Views/              # SwiftUI views (currently tightly coupled)
├── ViewModels/         # Business logic (needs DI implementation)
├── Models/             # Data models and CoreData entities
├── Utilities/          # Helper functions
└── Resources/          # Assets and configurations
```

> **Future Improvement**: Planning to implement proper Clean Architecture with better separation of concerns.

## Key Features & Implementation Notes

### CoreData Integration
```swift
// Current implementation in Persistence.swift
// Note: This is a basic setup, could be improved with repository pattern
class PersistenceController {
    static let shared = PersistenceController()
    let container: NSPersistentContainer
    // ... rest of implementation
}
```

### Vision Framework Usage
- Currently using basic OCR
- Direct Vision framework calls (could be abstracted better)
- Limited error handling (to be improved)

### Speech Recognition
- Basic implementation
- Permission handling needs improvement
- Limited offline capabilities

## Known Limitations & TODOs

### Current Limitations
1. No dependency injection (using singletons)
2. Limited test coverage
3. Basic error handling
4. Tight coupling in some components

### Planned Improvements
- [ ] Implement proper DI container
- [ ] Add basic unit tests
- [ ] Improve error handling
- [ ] Add repository pattern
- [ ] Implement proper navigation system

## Development Workflow

### Building & Running
1. Open `FridgeFriend.xcodeproj`
2. Select your target device/simulator
3. Run with ⌘R

### Common Issues & Solutions

#### 1. CoreData Errors
```swift
// If you see this error:
// "Failed to load model named FridgeFriend"
// Check: Is the .xcdatamodeld file included in target?
```

#### 2. Permission Issues
- Camera access fails? Check Info.plist entries
- Speech recognition not working? Verify microphone permissions

## Testing (Current State)

> **Note**: Testing is minimal at this stage. Here's how to run what we have:

```bash
# From terminal:
xcodebuild test -scheme FridgeFriend -destination 'platform=iOS Simulator,name=iPhone 15 Pro,OS=17.0'

# Or in Xcode:
# Use ⌘U to run tests
```

## Debugging Tips

### Xcode Configuration
- Enable "All Runtime Issues" in debug navigator
- Use Memory Graph for detecting retain cycles
- Console filtering for relevant logs

### Common Debug Scenarios
1. **UI Not Updating**
   - Check @Published properties
   - Verify ObservableObject conformance
   - Check view hierarchy

2. **CoreData Issues**
   - Enable SQL debug logging
   - Check fetch request predicates
   - Verify save context calls

## Git Workflow

```bash
# Feature development
git checkout -b feature/your-feature
# Make changes
git commit -m "feat: describe your changes"
git push origin feature/your-feature

# For fixes
git checkout -b fix/issue-description
```

## Privacy & Permissions

Required in Info.plist:
```xml
<key>NSCameraUsageDescription</key>
<string>For scanning food items</string>
<key>NSMicrophoneUsageDescription</key>
<string>For voice commands</string>
<!-- Add others as needed -->
```

## Resources & Learning Materials

### SwiftUI
- [Apple SwiftUI Tutorials](https://developer.apple.com/tutorials/swiftui)
- [Hacking with Swift](https://www.hackingwithswift.com)

### Vision Framework
- [Vision Framework Documentation](https://developer.apple.com/documentation/vision)

### CoreData
- [Core Data Programming Guide](https://developer.apple.com/documentation/coredata)

## Future Development Roadmap

### Phase 1 (Current)
- Basic MVVM implementation
- Core features working
- Minimal testing

### Phase 2 (Planned)
- Implement DI
- Add repository pattern
- Basic unit tests

### Phase 3 (Future)
- Clean Architecture
- Comprehensive testing
- Performance optimization

## Note to Contributors

This is a learning project that aims to grow into something more professional. While it may not follow all enterprise patterns yet, I'm working on improving it. Feedback and suggestions are welcome!

---
