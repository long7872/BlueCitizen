# BlueCitizen – Team Development Guide

Welcome to the BlueCitizen development team!

This document explains how to set up the project, work with Git, create feature branches, submit Pull Requests, and collaborate safely without accidentally affecting other members' work.

---

## 1. Development Environment

Before contributing, make sure you have installed:

- Flutter SDK
- Dart SDK (included with Flutter)
- Git
- Visual Studio Code or Android Studio
- Android Emulator or a physical device

### Clone the repository

Open a terminal and run:

```bash
git clone https://github.com/<github-username>/<repository-name>.git
```

Navigate into the project:

```bash
cd <repository-name>
```

Install dependencies:

```bash
flutter pub get
```

Check your Flutter environment:

```bash
flutter doctor
```

Run the application:

```bash
flutter run
```

Replace `<github-username>` and `<repository-name>` with the actual GitHub repository information.

---

## 2. Project Structure

BlueCitizen follows a feature-based architecture.

```text
lib/
├── main.dart
│
├── app/
│   ├── app.dart
│   ├── app_shell.dart
│   └── router/
│       ├── app_router.dart
│       ├── app_routes.dart
│       └── features/
│
├── core/
│   ├── theme/
│   └── widgets/
│
├── shared/
│   ├── models/
│   └── mock/
│
└── features/
    ├── map/
    ├── events/
    ├── report/
    ├── community/
    ├── profile/
    ├── notifications/
    ├── settings/
    ├── donate/
    ├── dashboard/
    ├── admin/
    └── knowledge/
```

### Architecture responsibilities

| Folder | Responsibility |
|---|---|
| `app/` | Application setup, navigation and app shell |
| `core/` | Shared UI components, theme and design system |
| `shared/` | Shared models, mock data and state |
| `features/` | Individual application features |

Each feature should keep its own screens and related implementation inside its feature folder.

Do not create duplicate route files. Feature route definitions are maintained in:

```text
lib/app/router/features/
```

---

## 3. Git Branching Strategy

**Never develop directly on `main`.**

Every member must create a separate branch for their assigned task.

### Branch naming convention

Use this format:

```text
feat/<feature>/<screen-name>
```

Examples:

```text
feat/map/map-screen
feat/events/events-screen
feat/report/report-screen
feat/community/community-screen
feat/profile/profile-screen
feat/notifications/notification-screen
feat/settings/settings-screen
feat/donate/donate-screen
feat/dashboard/dashboard-screen
feat/admin/admin-screen
feat/knowledge/knowledge-screen
```

For bug fixes:

```text
fix/<feature>/<issue-name>
```

Example:

```text
fix/report/validation-error
```

For refactoring:

```text
refactor/<feature>/<description>
```

Example:

```text
refactor/map/map-state-management
```

### Create a new feature branch

First, switch to `main`:

```bash
git switch main
```

Download the latest changes:

```bash
git pull origin main
```

Create your feature branch:

```bash
git switch -c feat/map/map-screen
```

Replace the example branch name with your assigned task.

---

## 4. Keep Your Branch Updated

Before starting work, always make sure your local `main` branch is up to date.

```bash
git switch main
git pull origin main
```

Return to your feature branch:

```bash
git switch feat/map/map-screen
```

Bring the latest changes from `main` into your branch:

```bash
git merge main
```

Resolve any merge conflicts before continuing.

Alternatively, when your team is comfortable with Git rebase, you may use:

```bash
git fetch origin
git rebase origin/main
```

Do not switch between merge and rebase randomly within the same workflow. Coordinate with your team if you are unsure.

---

## 5. Commit Message Convention

Use clear and consistent commit messages.

Format:

```text
<type>(<scope>): <description>
```

Common types:

| Type | Usage |
|---|---|
| `feat` | Add a new feature |
| `fix` | Fix a bug |
| `style` | UI or formatting changes without logic changes |
| `refactor` | Improve code structure |
| `docs` | Update documentation |
| `test` | Add or update tests |
| `chore` | Maintenance and configuration |

Examples:

```bash
git commit -m "feat(map): implement map screen"
git commit -m "feat(report): add report form"
git commit -m "fix(events): fix event detail navigation"
git commit -m "style(profile): improve profile layout"
git commit -m "docs(readme): update setup instructions"
```

Keep commits focused. Avoid combining unrelated changes into one commit.

---

## 6. Code Quality Before Pushing

Before pushing your changes, run:

### Format Dart files

```bash
dart format lib/
```

### Analyze the project

```bash
flutter analyze
```

### Run tests (when available)

```bash
flutter test
```

Fix errors and warnings introduced by your changes before creating a Pull Request.

Do not use `print()` for production logging. Prefer `debugPrint()` or an appropriate logging solution.

---

## 7. Push Your Feature Branch

After implementing your task:

```bash
git status
git add .
git commit -m "feat(map): implement map screen"
git push -u origin feat/map/map-screen
```

For subsequent updates to the same branch:

```bash
git add .
git commit -m "fix(map): improve map interaction"
git push
```

Never push directly to `main`.

---

## 8. Pull Request (PR) Workflow

All changes must be submitted through a Pull Request.

### Create a Pull Request

1. Open the BlueCitizen repository on GitHub.
2. Go to **Pull requests**.
3. Click **New pull request**.
4. Select the following branches:
   - Base: `main`
   - Compare: your feature branch
5. Click **Create pull request**.
6. Fill in the PR title and description.
7. Submit the PR for review.

### Pull Request title convention

Use the same convention as commit messages.

Examples:

```text
feat(map): implement map screen
feat(report): add report creation flow
fix(events): fix event navigation
```

### Pull Request description template

Copy and use this template:

```markdown
## Summary

Briefly describe what you implemented.

## Changes

- Added:
- Modified:
- Fixed:

## Screenshots

Attach screenshots of the updated UI when applicable.

## Testing

- [ ] flutter analyze
- [ ] flutter test (if applicable)
- [ ] Tested on emulator or physical device

## Checklist

- [ ] Code follows the project structure.
- [ ] No unrelated files were modified.
- [ ] No duplicated route definitions were added.
- [ ] The feature works as expected.
- [ ] Latest main changes have been integrated.
```

---

## 9. CODEOWNERS and Review Responsibilities

The repository uses `.github/CODEOWNERS` to assign code ownership.

Each feature has a responsible owner. Quỳnh and Long are responsible for reviewing shared project files.

Ownership mapping:

| Path | Responsible owner |
|---|---|
| `lib/features/map/` | Map owner |
| `lib/features/events/` | Events owner |
| `lib/features/report/` | Report owner |
| `lib/features/community/` | Community owner |
| `lib/features/profile/` | Profile owner |
| `lib/features/notifications/` | Notifications owner |
| `lib/features/settings/` | Settings owner |
| `lib/features/donate/` | Donate owner |
| `lib/features/dashboard/` | Dashboard owner |
| `lib/features/admin/` | Admin owner |
| `lib/features/knowledge/` | Knowledge owner |
| `lib/core/` | Quỳnh and Long |
| `lib/shared/` | Quỳnh and Long |
| `lib/app/` | Quỳnh and Long |
| `pubspec.yaml` | Quỳnh and Long |

Replace the owner names with the actual GitHub usernames in `.github/CODEOWNERS`.

### Important review rules

- Feature owners should review changes affecting their assigned features.
- Quỳnh and Long should review changes to shared architecture, core components, routing and dependencies.
- Reviewers should check code quality, architecture consistency and potential regressions.
- Do not approve code that you have not reviewed.

---

## 10. GitHub Branch Protection Rules

The `main` branch is protected.

The repository requires the following settings:

| Setting | Purpose |
|---|---|
| Require a pull request before merging | Prevent direct changes to `main` |
| Require approvals | Require at least one approval |
| Require review from Code Owners | Require approval from the relevant code owner |
| Dismiss stale pull request approvals when new commits are pushed | Require a new review when previously reviewed changes are modified |
| Require conversation resolution before merging | Ensure review discussions are resolved before merging |

### Dismiss stale pull request approvals

When a reviewer approves a PR and the author subsequently changes code covered by that approval, GitHub may dismiss the previous approval.

The updated changes need to be reviewed again before merging.

### Require conversation resolution before merging

When a reviewer leaves a comment requesting a change, the conversation must be resolved before the PR can be merged.

The author should:

1. Read the review comment.
2. Make the requested changes.
3. Push the updated code.
4. Reply to the reviewer when appropriate.
5. Ensure the conversation is marked as resolved.

Do not ignore unresolved review comments.

---

## 11. Merge Guidelines

Only merge a PR when:

- The required approvals have been received.
- Required Code Owner reviews are completed.
- All review conversations are resolved.
- There are no unresolved merge conflicts.
- Required checks have passed, if configured.

The repository maintainer or authorized merger should merge the PR into `main`.

After merging, GitHub may offer to delete the feature branch. Once the PR is merged, the feature branch can normally be deleted.

---

## 12. Start a New Task After Your PR Is Merged

Return to `main`:

```bash
git switch main
```

Download the latest code:

```bash
git pull origin main
```

Create another branch for your next task:

```bash
git switch -c feat/report/report-detail
```

Do not reuse an old feature branch for an unrelated task.

---

## 13. Common Git Commands

| Command | Description |
|---|---|
| `git status` | Check working tree status |
| `git branch` | List local branches |
| `git switch main` | Switch to main |
| `git pull origin main` | Update local main |
| `git switch -c <branch>` | Create and switch to a new branch |
| `git add .` | Stage changes |
| `git commit -m "message"` | Create a commit |
| `git push -u origin <branch>` | Push a new branch |
| `git push` | Push new commits |
| `git fetch origin` | Fetch remote updates |
| `git merge main` | Merge main into current branch |
| `git log --oneline` | View recent commits |

---

## 14. Team Collaboration Rules

1. Do not commit directly to `main`.
2. Do not push directly to `main`.
3. Always work on your assigned feature branch.
4. Pull the latest changes before starting a new task.
5. Avoid modifying files outside your assigned feature without coordination.
6. Ask the responsible owner before changing shared files.
7. Do not overwrite another member's work.
8. Keep commits small and meaningful.
9. Review your teammates' Pull Requests carefully.
10. Communicate with the team when encountering merge conflicts or architectural issues.

### Shared files require extra coordination

The following paths affect multiple features:

```text
lib/core/
lib/shared/
lib/app/
pubspec.yaml
```

Before modifying these files, coordinate with Quỳnh and Long.

For dependency changes in `pubspec.yaml`, explain why the new dependency is needed in your Pull Request.

---

## 15. Final Workflow Summary

Every feature contribution should follow this workflow:

```text
1. Clone the repository
       |
       v
2. Update local main
       |
       v
3. Create a feature branch
       |
       v
4. Implement the assigned task
       |
       v
5. Format and analyze the code
       |
       v
6. Commit and push the branch
       |
       v
7. Create a Pull Request
       |
       v
8. Wait for Code Owner review
       |
       v
9. Fix review comments
       |
       v
10. Resolve conversations and obtain approval
       |
       v
11. Merge into main
       |
       v
12. Update local main before the next task
```

---

**Thank you for contributing to BlueCitizen!**

Let's keep the codebase clean, maintainable and consistent while working together.
