# OSM Address Finder - Developer Documentation

## 📖 Documentation Structure

This documentation follows the **Diátaxis framework** for clear, purpose-driven content organization:

### 🟢 Tutorials (Learning-oriented)
- **[Getting Started Guide](getting-started.html)** - Set up and run the app
- **[Your First Feature](your-first-feature.html)** - Build a simple feature
- **[Understanding Clean Architecture](understanding-clean-architecture.html)** - Learn the architecture

### 🔧 How-to Guides (Problem-solving)
- **[Setup Development Environment](how-to-setup-development.html)** - Platform-specific setup
- **[Add a New Service](how-to-add-new-service.html)** - Implement service patterns
- **[Implement a New Cubit](how-to-implement-cubit.html)** - State management
- **[Debug Common Issues](how-to-debug-common-issues.html)** - Troubleshooting
- **[Test Your Features](how-to-test-features.html)** - Testing strategies

### 📚 Reference (Information-oriented)
- **[Architecture Reference](architecture-reference.html)** - Technical specifications
- **[API Reference](api-reference.html)** - API documentation
- **[Data Models](data-models.html)** - Complete data structure reference
- **[Codebase Structure](codebase-structure.html)** - Directory organization
- **[Dependencies & Tech Stack](dependencies.html)** - Package information
- **[Coding Standards](coding-standards.html)** - Style guidelines

### 💡 Explanation (Understanding-oriented)
- **[Why Clean Architecture?](why-clean-architecture.html)** - Architectural reasoning
- **[State Management Approach](state-management-approach.html)** - BLoC/Cubit rationale
- **[Error Handling Strategy](error-handling-strategy.html)** - Error design
- **[Design Decisions](design-decisions.html)** - Key choices explained

## 🚀 Quick Navigation

- **New Developer?** Start with [Getting Started Guide](getting-started.html)
- **Need to solve a problem?** Check [How-to Guides](#-how-to-guides-problem-solving)
- **Looking up technical details?** Use [Reference](#-reference-information-oriented)
- **Want to understand why?** Read [Explanations](#-explanation-understanding-oriented)

## 📱 Project Overview

**OSM Address Finder** is a Flutter application demonstrating Clean Architecture with:

- 🗺️ Interactive OpenStreetMap integration
- 🔍 Real-time address search with Nominatim API
- 📍 GPS location services
- 🏗️ Clean Architecture with Domain-Driven Design
- 📊 BLoC/Cubit state management
- ✅ Comprehensive error handling
- 🧪 Testable architecture

## 🎯 Implementation Status

- ✅ **Phase 1 - Interactive Map:** Complete (OSM tiles, location services, map controls)
- ✅ **Phase 2 - Address Search:** Complete (debounced search, suggestions, navigation)
- 🔄 **Phase 3 - Route Planning:** Planned
- 🔄 **Phase 4 - Offline Support:** Planned

## 🛠️ Tech Stack

- **Framework:** Flutter 3.32.0 / Dart 3.8.0
- **Architecture:** Clean Architecture with DDD
- **State Management:** BLoC/Cubit with flutter_bloc
- **Maps:** flutter_map with OpenStreetMap tiles
- **API:** Nominatim geocoding service
- **DI:** GetIt service locator
- **Code Generation:** Freezed for immutable models
- **Location:** Geolocator with permission_handler

## 📝 Contributing

1. Read [Getting Started Guide](getting-started.html) to set up development
2. Review [Coding Standards](coding-standards.html) for style guidelines
3. Understand [Architecture Reference](architecture-reference.html) for design patterns
4. Follow [How-to Guides](#-how-to-guides-problem-solving) for implementation patterns

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](../LICENSE) file for details.

---

**Need help?** Start with the [main documentation page](index.html) or check the relevant how-to guide for your specific task. 