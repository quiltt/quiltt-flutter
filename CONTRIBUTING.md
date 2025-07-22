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

```
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

We use conventional commits for clear commit history:

- `feat:` - New features
- `fix:` - Bug fixes
- `docs:` - Documentation changes
- `style:` - Code style changes (formatting, etc.)
- `refactor:` - Code refactoring
- `test:` - Adding or updating tests
- `chore:` - Maintenance tasks

Example: `fix: resolve Finicity OAuth redirect handling`

### Testing

- **Test your changes** on both iOS and Android
- **Run the example app** to verify functionality
- **Test with multiple connectors** if possible (Plaid, Finicity, etc.)
- **Verify OAuth flows** work correctly
- **Check for memory leaks** in WebView handling

### Pull Request Guidelines

**Pull Request Template:**

```md
## Description
Brief description of changes made.

## Type of Change
- [ ] Bug fix (non-breaking change which fixes an issue)
- [ ] New feature (non-breaking change which adds functionality)
- [ ] Breaking change (fix or feature that would cause existing functionality to not work as expected)
- [ ] Documentation update

## Testing
- [ ] Tested on iOS
- [ ] Tested on Android
- [ ] Tested with example app
- [ ] Tested OAuth redirects

## Checklist
- [ ] Code follows project style guidelines
- [ ] Self-review completed
- [ ] Documentation updated (if applicable)
- [ ] No breaking changes (or clearly documented)
```

## Release Process

The project uses automated releases via Fastlane:

- **Patch releases** (`fastlane release_patch`) - Bug fixes
- **Minor releases** (`fastlane release_minor`) - New features
- **Major releases** (`fastlane release_major`) - Breaking changes

Maintainers handle releases, but contributors should indicate the type of change in their PRs.

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
