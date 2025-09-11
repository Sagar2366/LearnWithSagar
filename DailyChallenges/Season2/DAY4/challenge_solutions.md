
---

# ✅ `challenge_solution.md` 


# Day 4: Advanced Git Mastery

**Name:** Swayam Prakash Bhuyan  
**Date:** 11 September 2025  

---

## ✅ Task 1 – Amend a Commit

### Commands used:
```bash
echo "Initial content" > file.txt
git add file.txt
git commit -m "Initial commit"

echo "Updated content" >> file.txt
git add file.txt

git commit --amend -m "feature: Add updated content to file"

git log --oneline -10
````

### Screenshot:

![alt text](image.png)

### Diagram:

```
A[Initial commit] --> B[Staged changes]
B --> C[Amended commit]
```

### Result:

The commit message was changed to “feature: Add updated content to file”, and the file now includes both initial and updated content without creating a new commit.

---

## ✅ Task 2 – Interactive Rebase

### Commands used:

```bash
echo "Change 1" >> file.txt
git add file.txt
git commit -m "Change 1"

echo "Change 2" >> file.txt
git add file.txt
git commit -m "Change 2"

echo "Change 3" >> file.txt
git add file.txt
git commit -m "Change 3"

git rebase -i HEAD~3
# In the editor: pick Change 1, squash Change 2 and Change 3
git rebase --continue

git log --oneline
```

### Screenshot:

![alt text](image-1.png)
![alt text](image-2.png)
### Diagram:

```
A[Change 1] --> B[Change 2]
B --> C[Change 3]
D[Rebase] --> E[Squash Commits 2 & 3]
E --> F[Final Commit]
```

### Result:

The last two commits were combined into one, with the new commit message updated accordingly. The commit history is cleaner and easier to understand.

---

## ✅ Task 3 – Tag a Release

### Commands used:

```bash
git tag -a v2.0.0 -m "Release version 2.0.0"
git push origin --tags

git tag v1.0.0 # Lightweight

```

### Screenshot:

![alt text](image-3.png)

### Diagram:

```
A[Commit] --> B[v2.0.0 Tag]
```

### Result:

A new annotated tag `v2.0.0` was created with a description and pushed to GitHub.

---

## ✅ Task 4 – Sync with Upstream

### Commands used:

```bash
git remote add upstream https://github.com/Sagar2366/LearnWithSagar.git
git fetch upstream
git merge upstream/main
```

### Screenshot:

![alt text](image-4.png)

### Diagram:

```
Original Repo --> Upstream --> Your Fork
Your Fork --> Origin --> Local Machine
Local Machine --fetch upstream--> Original Repo
```

### Result:

The upstream repository’s changes were successfully merged into the local repository without losing existing changes.

---

## ✅ Task 5 – Stash and Cherry-Pick

### Commands used:

```bash
echo "Stash content" >> file.txt
git add file.txt

git stash

git checkout -b hotfix

random lines for cherry pick

git cherry-pick <commit-hash>   # Replace <commit-hash> with the actual commit ID

git stash pop
```

### Screenshot:

![alt text](image-5.png)

### Diagram:

```
FeatureBranch --stash--> HotfixBranch --cherry-pick--> Applied Commit
```

### Result:

Uncommitted changes were safely stored using `git stash`, applied to another branch using `git cherry-pick`, and then restored using `git stash pop`.

---

## ✅ Task 6 – Rebase a Feature Branch

### Commands used:

```bash
git checkout feature
git fetch origin
git rebase origin/main

main commits for example1

# If conflicts occur:
git add <file>
git rebase --continue

git push --force
```

### Screenshot:

![Rebase Feature Screenshot](./screenshots/rebase_feature.png)

### Diagram:

```
Main --> Feature Branch --> Rebased onto Main --> Clean history
```

### Result:

The feature branch was rebased onto the main branch, conflicts were resolved, and the history is now linear.

---

## ✅ Task 7 – Undo with Revert

### Commands used:

```bash
git revert <commit-hash>   # Replace <commit-hash> with the actual commit ID

git log --oneline
```

### Screenshot:

![Revert Commit Screenshot](./screenshots/revert_commit.png)

### Diagram:

```
A[Original Commit] --> B[Revert Commit]
```

### Result:

A new commit was created that undoes the changes introduced by the specified commit, keeping history safe and intact.

---

## ✅ Task 8 – Branching Strategies

### Gitflow

* Description: A structured workflow for teams with scheduled releases, using feature, release, and hotfix branches.

```mermaid
graph TD
A[main] --> B[develop]
B --> C[feature]
B --> D[release]
A --> E[hotfix]
```

### Screenshot:

![Gitflow Screenshot](./screenshots/gitflow.png)

### GitHub Flow

* Description: A lightweight workflow where all work is done in feature branches and merged into main after review.

```mermaid
graph TD
A[main] --> B[feature]
B --> A
```

### Screenshot:

![GitHub Flow Screenshot](./screenshots/github_flow.png)

### Trunk-Based Development

* Description: Developers commit directly to the main branch, using feature toggles to manage incomplete features.

```mermaid
graph TD
A[main] --> B[dev changes]
B --> A
```

### Screenshot:

![Trunk-Based Development Screenshot](./screenshots/trunk_based.png)

### Chosen Strategies

1. **For a small team with continuous deployment → GitHub Flow**
   **Reason:** It’s simple, quick, and reduces overhead while allowing fast deployments.

2. **For a large team with monthly releases → Gitflow**
   **Reason:** It offers a controlled environment with multiple branches that suit scheduled releases and better quality assurance.

---

## ✅ Submission Checklist

* ✅ Completed all tasks with commands and explanations
* ✅ Added diagrams for each workflow
* ✅ Inserted screenshots under each command block
* ✅ Pushed code to GitHub
* ✅ Created PR titled **Day 4: Advanced Git Mastery**
* ✅ Shared on LinkedIn with hashtags: `#getfitwithsagar #DevOpsForAll`

---
