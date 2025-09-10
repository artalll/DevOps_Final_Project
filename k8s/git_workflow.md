# Git Workflow Documentation

# Overview

This document describes the Git branching strategy and workflow used for the `DevOps_Final_Project`.
It covers repository setup, branch management, commits, pull requests, and conflict resolution (if applicable).

---


## Repository Setup

- The project is hosted on GitHub at:
  - `https://github.com/artalll/DevOps_Final_Project`

- Initial project files were committed to the `main` branch.

---

## Branching Strategy

We used a common Git branching model for collaborative and test-driven development:

`main`            Stable production-ready code
`dev`             Development and integration
`conflict-demo`   Simulates merge conflict scenario

---

## Workflow
## Creating a New Branch

```bash
git checkout -b conflict-demo
```

## Making Changes

Changes were made to the `README.md` or another file to simulate different versions between branches.

## Committing Changes

```bash
git add README.md
git commit -m "Update version to v2 in conflict-demo"
```

## Pushing to Remote

```bash
git push origin conflict-demo
```

## Creating a Pull Request

A pull request was opened from `conflict-demo` to `dev`:
- GitHub automatically checked for merge conflicts.
- In this case: "No conflicts with base branch".

## Merging Pull Request

The pull request was merged into the `dev` branch using the GitHub UI.

---

## Notes on Conflict Resolution (Optional)

If you want to simulate and resolve a real conflict:
- Make **conflicting changes** to the same lines in a file in two different branches.
- GitHub will notify: "This branch has conflicts..."_
- You can resolve them via GitHub editor or CLI.
---

## Summary

- Git repository includes clear branching strategy.
- Pull requests and merges were used effectively.
- All Git actions are traceable and follow best practices.
