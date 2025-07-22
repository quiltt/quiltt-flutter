# Releasing the Quiltt Flutter SDK

This guide explains how to cut new releases of the Flutter SDK using our automated release process.

## Overview

The Quiltt Flutter SDK uses **label-based automated releases**. When you merge a PR with a release label, the system automatically:

- Bumps the version number
- Updates the changelog
- Publishes to pub.dev
- Creates a GitHub release

**No manual commands needed!** 🎉

## Release Types

We follow [Semantic Versioning](https://semver.org/) (semver):

| Label | Version Change | When to Use |
|-------|---------------|-------------|
| `release:patch` | `3.0.2 → 3.0.3` | Bug fixes, documentation updates |
| `release:minor` | `3.0.2 → 3.1.0` | New features, enhancements (backward compatible) |
| `release:major` | `3.0.2 → 4.0.0` | Breaking changes, major API changes |

## How to Release

### Step 1: Create Your PR

Create a pull request with your changes as usual:

```bash
git checkout -b fix/finicity-oauth-issue
# Make your changes...
git commit -m "fix: resolve Finicity OAuth redirect handling"
git push origin fix/finicity-oauth-issue
```

### Step 2: Add Release Label

**Before merging**, add the appropriate release label to your PR:

1. Go to your PR on GitHub
2. Click the **Labels** section on the right side
3. Select the appropriate release label:
   - 🐛 **`release:patch`** - for bug fixes
   - ✨ **`release:minor`** - for new features  
   - 💥 **`release:major`** - for breaking changes

### Step 3: Get PR Reviewed and Merged

Follow normal review process, then merge the PR. **The release happens automatically on merge!**

### Step 4: Verify Release

After merging, check:

- ✅ **GitHub Actions**: Go to Actions tab, verify "Automated Release and Publish" succeeds
- ✅ **pub.dev**: Check [quiltt_connector on pub.dev](https://pub.dev/packages/quiltt_connector) for new version
- ✅ **GitHub Releases**: Check the [Releases page](../../releases) for the new release
- ✅ **PR Comment**: The automation will comment on your PR with success details

## Examples

### Bug Fix Release

```md
PR: "Fix WebView white screen issue for Finicity"
Label: release:patch
Result: 3.0.2 → 3.0.3
```

### New Feature Release  

```md
PR: "Add support for new OAuth provider"
Label: release:minor  
Result: 3.0.2 → 3.1.0
```

### Breaking Change Release

```md
PR: "Remove deprecated authenticate() method"
Label: release:major
Result: 3.0.2 → 4.0.0
```

## What Happens Automatically

When you merge a labeled PR, the automation:

1. **Detects the release label** on your merged PR
2. **Calculates new version** based on current version + label type
3. **Updates version files**:
   - `pubspec.yaml`
   - `lib/quiltt_sdk_version.dart`
4. **Updates CHANGELOG.md** with your PR title and commits
5. **Commits changes** back to main branch
6. **Creates Git tag** (e.g., `v3.0.3`)
7. **Validates package** with `flutter pub publish --dry-run`
8. **Publishes to pub.dev** automatically
9. **Creates GitHub release** with release notes
10. **Comments on your PR** with success details

## Troubleshooting

### No Release Happened

**Problem**: Merged PR but no release was created.
**Solution**: Check that your PR had a `release:*` label before merging.

### Release Failed

**Problem**: GitHub Actions shows red X on release workflow.
**Solution**:

1. Check the Actions logs for specific error
2. Common issues:
   - Missing `PUB_DEV_CREDENTIALS` secret
   - Flutter analysis errors
   - Version conflicts

### Wrong Version Number

**Problem**: Released wrong version type (e.g., minor instead of patch).
**Solution**:

1. Create a new PR to fix any issues
2. Use the correct label for the follow-up release
3. The version number will continue from the previous release

### Manual Release Needed

**Problem**: Need to release without a PR (hotfix, emergency).
**Solution**: Create a minimal PR with the fix and proper label, then merge.

## Best Practices

### ✅ Do

- **Always add release labels** before merging
- **Use descriptive PR titles** (they become changelog entries)
- **Test your changes** thoroughly before labeling for release
- **Use patch releases** for bug fixes and documentation
- **Use minor releases** for new features
- **Use major releases** sparingly, only for breaking changes

### ❌ Don't

- **Don't merge without a release label** if you intend to release
- **Don't use major releases** for non-breaking changes
- **Don't manually edit version files** (automation handles this)
- **Don't create manual Git tags** (automation handles this)

## Emergency Releases

For urgent hotfixes:

1. **Create hotfix branch** from main
2. **Make minimal fix**
3. **Create PR** with clear title describing the emergency
4. **Add `release:patch` label**
5. **Get expedited review**
6. **Merge immediately**

The automation will handle the emergency release within minutes.

## Getting Help

- **GitHub Actions failing?** Check the [Actions tab](../../actions) for detailed logs
- **pub.dev issues?** Verify `PUB_DEV_CREDENTIALS` secret is set correctly
- **Questions about semver?** See [Semantic Versioning](https://semver.org/)
- **Need help?** Ask in #engineering-flutter or create an issue

## Current Version

You can always check the current version:

- **pubspec.yaml**: `version: X.Y.Z`
- **pub.dev**: [Latest version](https://pub.dev/packages/quiltt_connector)
- **GitHub**: [Latest release](../../releases/latest)

---

Happy releasing! 🚀
