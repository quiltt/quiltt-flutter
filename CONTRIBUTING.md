# Contributing to Quiltt Flutter SDK

First off, thank you for considering contributing to the Quiltt Flutter SDK. It's people like you that make Quiltt such a great tool for developers in the fintech space. We welcome contributions from everyone as part of our mission to build powerful, user-friendly tools for financial technology applications.

## Getting Started

Before you begin, please ensure you have:

- A GitHub account
- Flutter development environment set up (Flutter 3.24.0+, Dart 3.5.0+)
- Familiarity with the Quiltt documentation at [https://quiltt.dev](https://quiltt.dev)
- Understanding of Flutter plugin development and WebView integration

Understanding Quiltt's core concepts and the Flutter SDK's architecture will help you make meaningful contributions.

## Development Setup

1. **Clone the repository:**

   ```bash
   git clone https://github.com/quiltt/quiltt-flutter.git
   cd quiltt-flutter
   ```

2. **Install dependencies:**

   ```bash
   flutter pub get
   ```

3. **Set up the example app:**

   ```bash
   cd example
   flutter pub get
   ```

4. **Install Fastlane (for releases):**

   ```bash
   bundle install
   ```

## Project Structure

```txt
├── lib/                    # Main SDK source code
│   ├── quiltt_connector.dart     # Main SDK entry point
│   ├── configuration.dart        # Configuration classes
│   ├── event.dart                # Event callback definitions
│   ├── url_utils.dart            # URL encoding utilities
│   └── quiltt_sdk_version.dart   # Version information
├── example/                # Example Flutter app
├── fastlane/              # Release automation
└── .github/workflows/     # CI/CD pipelines
```

## Ways to Contribute

There are many ways to contribute to the Quiltt Flutter SDK:

### Reporting Bugs

- **Use the GitHub Issues tracker** to submit bug reports
- **Search existing issues** to avoid duplicates
- **Provide detailed information:**
  - Flutter and Dart versions
  - iOS/Android versions being tested
  - Steps to reproduce the issue
  - Expected vs actual behavior
  - Console logs or error messages
  - Connector ID (if applicable) for debugging

**Bug Report Template:**

```md
**Describe the bug**
A clear description of what the bug is.

**To Reproduce**
Steps to reproduce the behavior:
1. Configure SDK with '...'
2. Call method '...'
3. See error

**Expected behavior**
What you expected to happen.

**Environment:**
- Flutter version: [e.g. 3.24.0]
- Dart version: [e.g. 3.5.0]
- Platform: [iOS/Android]
- Device: [e.g. iPhone 14, Pixel 7]
- SDK version: [e.g. 3.0.1]

**Additional context**
Any other context about the problem.
```

### Feature Requests

- **Use the GitHub Issues tracker** for feature requests
- **Search existing requests** to avoid duplicates
- **Provide clear explanations:**
  - Use case and business justification
  - Proposed API design
  - Examples of how it would work
  - Consideration for iOS/Android differences

### Platform Support

We welcome contributions to extend platform support:

- **Web support** - WebView integration for Flutter web
- **macOS/Windows/Linux** - Desktop platform implementations
- **Platform-specific optimizations**

## Submitting Code Changes

### Development Workflow

1. **Fork the repository** on GitHub
2. **Clone your fork** locally:

   ```bash
   git clone https://github.com/YOUR_USERNAME/quiltt-flutter.git
   ```

3. **Create a feature branch:**

   ```bash
   git checkout -b feature/your-feature-name
   ```

4. **Make your changes** following our coding standards
5. **Test your changes** thoroughly
6. **Commit with descriptive messages:**

   ```bash
   git commit -m "feat: add support for custom user agents"
   ```

7. **Push to your fork:**

   ```bash
   git push origin feature/your-feature-name
   ```

8. **Submit a pull request** against the `main` branch

### Coding Standards

- **Follow Dart conventions** from the [Dart Style Guide](https://dart.dev/guides/language/effective-dart/style)
- **Use meaningful variable names** and add comments for complex logic
- **Maintain consistency** with existing code patterns
- **Handle errors gracefully** with proper try-catch blocks
- **Add documentation** for public APIs
- **Test on both iOS and Android** platforms

### Commit Message Format

We prefer clear, descriptive commit messages that start with action verbs:

- `Add` - New features or functionality
- `Fix` - Bug fixes
- `Update` - Changes to existing features
- `Refactor` - Code restructuring without functional changes
- `Remove` - Deleting code or features
- `Improve` - Enhancements to existing functionality

**Examples:**

- `Add support for custom OAuth redirect URLs`
- `Fix Finicity OAuth redirect handling`
- `Update URLUtils to match iOS behavior`
- `Refactor WebView navigation logic`

**Note:** Release versioning is handled automatically via PR labels, not commit message conventions.

### Testing

- **Test your changes** on both iOS and Android
- **Run the example app** to verify functionality
- **Test with multiple connectors** if possible (Plaid, Finicity, etc.)
- **Verify OAuth flows** work correctly
- **Check for memory leaks** in WebView handling

### Pull Request Guidelines

**Pull Request Template:**

See [pull_request_template.md](./.github/pull_request_template.md)

## Release Process

The project uses **automated label-based releases**:

- **Patch releases** (`release:patch` label) - Bug fixes, documentation updates
- **Minor releases** (`release:minor` label) - New features, enhancements  
- **Major releases** (`release:major` label) - Breaking changes, major API changes

### How to Trigger a Release

1. **Create your PR** with changes
2. **Add appropriate release label** before merging:
   - `release:patch` for bug fixes
   - `release:minor` for new features
   - `release:major` for breaking changes
3. **Merge the PR** - Release happens automatically!

The automation will:

- Calculate new version number
- Update `pubspec.yaml` and `lib/quiltt_sdk_version.dart`
- Update `CHANGELOG.md` with your changes
- Publish to pub.dev
- Create GitHub release

**No manual commands needed!** See [RELEASING.md](RELEASING.md) for detailed instructions.

Contributors should indicate the type of change in their PRs using the pull request template.

## Code Review Process

1. **Automated checks** run via GitHub Actions
2. **Maintainer review** for code quality and architecture
3. **Testing verification** on multiple platforms
4. **Feedback and iteration** if changes are needed
5. **Approval and merge** once requirements are met

Reviews help ensure code quality, consistency, and maintainability. Please be open to feedback and discussion.

## Community Guidelines

We want to foster an inclusive and friendly community around the Quiltt Flutter SDK. We expect everyone to:

- **Be respectful** in all interactions
- **Provide constructive feedback** during code reviews
- **Help newcomers** get started with contributions
- **Share knowledge** about Flutter development and fintech integration

## Questions and Support

- **GitHub Issues** - For bugs and feature requests
- **GitHub Discussions** - For questions and community support
- **Pull Request comments** - For code-specific questions
- **Documentation** - Check [quiltt.dev](https://quiltt.dev) for SDK guides

## Thank You

Thank you for your interest in contributing to the Quiltt Flutter SDK! Together, we can make financial technology integration easier and more accessible for Flutter developers worldwide.
