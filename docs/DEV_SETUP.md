# FridgeFriend Developer Setup Guide

This guide provides detailed instructions for setting up the FridgeFriend development environment. While this is a college project, we maintain professional development practices to ensure code quality and consistent development experience.

## Prerequisites

### Required Software
- Xcode 15.0 or later
- iOS 17.0 SDK
- Git
- Swift 5.0+
- macOS Sonoma 14.0+ (recommended)

### Apple Developer Account
- A free Apple Developer account is sufficient for development
- Full Apple Developer Program membership ($99/year) required only for App Store deployment

## Initial Setup

### 1. Environment Setup
```bash
# Check Xcode command line tools installation
xcode-select --install

# Verify Swift version
swift --version

# Check Git installation
git --version
```

### 2. Repository Setup
```bash
# Clone the repository
git clone https://github.com/Eissxs/FridgeFriend.git

# Navigate to project directory
cd FridgeFriend

# Initialize Git LFS (if needed for large assets)
git lfs install
```

### 3. Project Configuration
1. Open `FridgeFriend.xcodeproj` in Xcode
2. Select your development team in project settings (if available)
3. Update the Bundle Identifier if needed
4. Ensure the deployment target is set to iOS 17.0

## Development Workflow

### Building the Project
1. Select your target device/simulator
2. Build the project (⌘B)
3. Run the project (⌘R)

### Core Data Development
- The data model is located in `FridgeFriend.xcdatamodeld`
- Always create a backup before modifying the data model
- Test migrations thoroughly if you modify the schema

### Working with Vision & Speech Frameworks
```swift
// Required import statements
import Vision
import Speech

// Remember to add usage descriptions in Info.plist:
// NSCameraUsageDescription
// NSPhotoLibraryUsageDescription
// NSSpeechRecognitionUsageDescription
// NSMicrophoneUsageDescription
```

## Testing

### Running Tests
```bash
# Run tests from command line
xcodebuild test -scheme FridgeFriend -destination 'platform=iOS Simulator,name=iPhone 15 Pro,OS=17.0'

# Or use Xcode's Test Navigator (⌘6)
```

### Test Coverage
- Current test coverage is minimal (educational project)
- Focus on critical path testing when adding new features
- UI tests are optional but recommended for main user flows

## Debugging

### Common Issues
1. **CoreData Errors**
   - Check entity relationships
   - Verify attribute types
   - Ensure proper error handling

2. **Permission Issues**
   - Verify Info.plist entries
   - Check permission request timing
   - Test on physical devices

3. **Vision Framework**
   - Test with various image types
   - Handle poor lighting conditions
   - Consider performance impact

### Development Tools
- Xcode Memory Debugger
- Instruments for performance profiling
- Console.app for device logs

## Code Style Guidelines

### Swift Style
- Follow Swift API Design Guidelines
- Use SwiftLint for consistency (optional)
- Maintain clear documentation comments

### Project Structure
```
FridgeFriend/
├── Views/          # SwiftUI views
├── Models/         # Data models
├── ViewModels/     # Business logic
├── Utilities/      # Helper functions
└── Resources/      # Assets, plists
```

## Contribution Guidelines

### Git Workflow
```bash
# Create feature branch
git checkout -b feature/your-feature-name

# Make commits with clear messages
git commit -m "feat: add item expiry notification"

# Push changes
git push origin feature/your-feature-name
```

### Pull Request Process
1. Update documentation if needed
2. Test your changes thoroughly
3. Request review from maintainers
4. Address feedback promptly

## Performance Considerations

### Memory Management
- Use instruments to profile memory usage
- Implement proper cleanup in view lifecycles
- Be mindful of image caching

### Battery Usage
- Optimize camera and speech recognition usage
- Implement proper background task handling
- Test on physical devices

## Resources

### Documentation
- [Swift Documentation](https://swift.org/documentation/)
- [Apple Developer Documentation](https://developer.apple.com/documentation/)
- [SwiftUI Tutorials](https://developer.apple.com/tutorials/swiftui)

### Tools
- [Xcode](https://developer.apple.com/xcode/)
- [Swift Package Manager](https://swift.org/package-manager/)

## Support

For questions or issues:
- Open an issue on GitHub
- Check existing documentation
- Contact project maintainers

## Note on Project Scope

This is an educational project developed for ITEL315 – Elective iOS Development. While we maintain professional practices, some enterprise-level features and configurations are intentionally simplified or omitted to align with the course objectives.

---
