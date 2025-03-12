## Hello Learners,

Welcome to the **DevOps SRE Daily Challenge!**

Today, we dive into **Advanced Git and GitHub**, focusing on critical workflows like undoing changes, rewriting history, managing releases, and collaborating with multiple remotes. Let's combine theory with clear and professional visuals for better understanding.

## Advanced Git Concepts

### 1. Amending Commits

**Theory:** The `git commit --amend` command modifies the most recent commit.

**Use Cases:**

*   Fix typos in commit messages.
*   Add missed changes to the commit.

**Visual Workflow:**

```
A[Original Commit] --> B[Stage Changes]
B --> C[git commit --amend]
C --> D[Updated Commit]

```
**Example:**
```
git add .
git commit --amend -m "feat: Add login validation with updated test cases"
```

### 2. Rewriting History with Interactive Rebase

**Theory:** Interactive rebasing (`git rebase -i`) allows you to:

*   Squash commits: Combine small commits into one.
*   Reword messages: Clarify commit descriptions.
*   Drop commits: Remove accidental changes.

**Visual Workflow:**

```
A[Commit 1] --> B[Commit 2]
B --> C[Commit 3]
D[Rebase Command] --> E[Squash Commits 2 & 3]
E --> F[Final Commit]
```
**Steps:**
```
git rebase -i HEAD~3
```
Follow prompts to squash, reword, or drop commits
```git rebase --continue```


### 3. Tagging Releases

**Theory:** Tags mark releases in history.

*   Lightweight Tags: Point directly to commits.
*   Annotated Tags: Include metadata (author, message).

**Visual Comparison:**

```
title Tag Types
"Lightweight (v1.0.0)" : 50
"Annotated (v1.1.0)" : 50
```

**Steps:**
```
git tag v1.0.0 # Lightweight
git tag -a v1.1.0 -m "Stable release with auth fixes"
git push origin --tags
```


### 4. Syncing with Upstream

**Theory:** When collaborating:

*   `origin`: Your forked repository.
*   `upstream`: The original repository.

**Visual Workflow:**

```
A[Original Repo] -->|upstream| B[Your Fork]
B -->|origin| C[Local Machine]
C -->|git fetch upstream| A
```


**Steps:**
```
git remote add upstream https://github.com/original/repo.git
git fetch upstream
git merge upstream/main
```


### 5. Stashing and Cherry-Picking

**Theory:**

*   Stashing: Temporarily saves uncommitted changes.
*   Cherry-Picking: Applies a specific commit from another branch.

**Visual Workflow:**

```
participant FeatureBranch
participant HotfixBranch
FeatureBranch->>HotfixBranch: git cherry-pick abc123
HotfixBranch->>FeatureBranch: Apply commit
```


**Steps:**

git stash
git checkout hotfix
git cherry-pick abc123
git stash pop



### 6. Rebasing vs. Merging

**Theory:**

*   Rebasing: Linear history (ideal for feature branches).
*   Merging: Preserves branch history.

**Comparison:**

```
A[Rebase] -->|Linear History| B[Clean Timeline]
C[Merge] -->|Merge Commits| D[Branch Con]
```


**Rebase Workflow:**
```
git fetch origin
git rebase origin/main
git push --force
```


### 7. Undoing Changes

**Theory:**

*   `git reset`: Discard commits (use cautiously!).
*   `git revert`: Safely undo commits.

**Comparison Table:**
```
| Command        | Use Case                        | Risk Level |
|----------------|---------------------------------|------------|
| `reset --soft` | Uncommit but keep changes       | Low        |
| `reset --hard` | Discard changes permanently      | High       |
| `revert`       | Create undo commit              | None       |
```
**Example:**
```
git reset --soft HEAD~1
git revert abc123
```

### 8. Git Branching Strategies

**Theory:** Branching strategies are workflows for managing code development and collaboration using Git branches. Choosing the right strategy depends on your team size, release frequency, and project complexity.  Common strategies include:

*   **Gitflow:** A strict model designed for scheduled releases. It uses feature branches, release branches, and hotfix branches, in addition to the main and develop branches.
*   **GitHub Flow:** A simpler workflow where everything in the `main` branch is deployable. Feature branches are created off main and merged back in after review.
*   **Trunk-Based Development:** Developers commit directly to the main branch, keeping it continuously deployable. Feature toggles are often used to manage incomplete features.

  

## Challenge Tasks

### Task 1: Amend a Commit

*   Modify a file and amend the commit.
*   Verify with `git log --oneline`.

### Task 2: Interactive Rebase

*   Rebase the last 3 commits.
*   Squash two commits and reword a message.

### Task 3: Tag a Release

*   Create an annotated tag `v2.0.0`.
*   Push tags to GitHub.

### Task 4: Sync with Upstream

*   Fork a repo, add `upstream`, and sync changes.

### Task 5: Stash and Cherry-Pick

*   Stash changes, switch branches, and apply a commit.

### Task 6: Rebase a Feature Branch

*   Rebase onto `main`, resolve conflicts, and push.

### Task 7: Undo with Revert

*   Revert a commit and verify the new undo commit.

### Task 8: Branching strategies
*  Research Gitflow, GitHub Flow, and Trunk-Based Development more thoroughly.
* Create a simple diagram (using Mermaid or similar) for *each* strategy illustrating the branch relationships and workflow.
*  Choose the strategy that you think would be *most* appropriate for:
    * A small team working on a web application with continuous deployment.
    * A large team working on an enterprise software product with monthly releases.
    Explain your reasoning.

## Key Interview Q&A with Visuals

### Q1: What is the difference between `git reset --hard` and `git revert`?

**A:**

```
A[Original Commit] --> B[reset --hard: Delete History]
A --> C[revert: Add Inverse Commit]
```


### Q2: What is the difference between `origin` and `upstream`?

**A:**

```
A[Upstream] -->|Original| B[GitHub]
B -->|Fork| C[Origin]
C -->|Clone| D[Local]
```


### Q3: What is the difference between `git merge` and `git rebase`?

**A:**

```
A[Rebase] -->|Linear History| B[Clean Timeline]
C[Merge] -->|Merge Commits| D[Branch Con]
```


### Q4: How do you resolve a merge conflict?

**A:**

*   Identify the conflicting files using `git status`.
*   Open the files and resolve the conflicts manually.
*   Stage the resolved files using `git add`.
*   Complete the merge with `git commit`.

**Example:**

Resolve conflicts in file.txt
```
git add file.txt
git commit -m "Resolved merge conflict in file.txt"
```


### Q5: What is the purpose of `git stash`?

**A:** `git stash` temporarily saves uncommitted changes, allowing you to switch branches or perform other tasks without committing incomplete work.

**Example:**
```
git stash # Save changes
git checkout main # Switch branches
git stash pop # Reapply changes
```


### Q6: What is the difference between a lightweight tag and an annotated tag?

**A:**

*   Lightweight Tag: A simple pointer to a specific commit.
*   Annotated Tag: A full Git object with metadata (tagger name, email, message).

**Example:**
```
git tag v1.0.0 # Lightweight tag
git tag -a v1.1.0 -m "Release" # Annotated tag
```


### Q7: How do you cherry-pick a commit?

**A:** Use `git cherry-pick <commit-hash>` to apply a specific commit from one branch to another.

**Example:**
```
git checkout feature-branch
git cherry-pick abc123 # Apply commit abc123 to feature-branch
```


### Q8: What is the purpose of `git rebase -i`?

**A:** Interactive rebasing allows you to:

*   Squash multiple commits into one.
*   Reword commit messages.
*   Drop unwanted commits.

**Example:**
```
git rebase -i HEAD~3 # Edit the last 3 commits
```


### Q9: How do you undo the last commit without losing changes?

**A:** Use `git reset --soft HEAD~1` to uncommit the last commit but keep the changes staged.

**Example:**
```
git reset --soft HEAD~1 # Undo last commit, keep changes staged
```

### Q10: What is the difference between `git fetch` and `git pull`?

**A:**

*   `git fetch`: Downloads changes from the remote repository but does not merge them.
*   `git pull`: Downloads changes and automatically merges them into the current branch.

**Example:**
```
git fetch origin # Download changes
git pull origin # Download and merge changes
```


### Q11: How do you delete a remote branch?

**A:**
```
git push origin --delete <branch-name>
```

### Q12: What is the purpose of git reflog?
A:
git reflog shows a log of all changes to the branch’s HEAD, including resets and rebases. It helps recover lost commits.

**Example:**
```
git reflog  # View reflog
git reset --hard HEAD@{1}  # Recover a lost commit
```

### Q13: How do you squash the last N commits into one?
**A:**
Use interactive rebase to squash commits:

```
git rebase -i HEAD~N  # Squash the last N commits
```

### Q14: What is the difference between git reset --soft, --mixed, and --hard?
**A:**

Command	Effect on Working Directory	Effect on Staging Area
reset --soft	No change	No change
reset --mixed	No change	Unstages changes
reset --hard	Discards changes	Discards changes

### Q15: How do you create and apply a patch in Git?
**A:**

Create a patch:
```
git format-patch -1 <commit-hash>  # Create patch for a specific commit
```

Apply a patch:
```
git apply <patch-file>  # Apply the patch
```

### Q16: What is the purpose of git bisect?
**A:**
git bisect helps find the commit that introduced a bug by performing a binary search through the commit history.

**Example:**
```
git bisect start
git bisect bad   # Mark current commit as bad
git bisect good <commit-hash>  # Mark a known good commit
```

### Q17: How do you rename a branch in Git?
**A:**
Use git branch -m <old-name> <new-name> to rename a branch.

**Example:**
```
git branch -m feature-old feature-new  # Rename branch
```

### Q18: What is the purpose of git submodule?
**A:**
git submodule allows you to include another repository within your project as a subdirectory.

**Example:**
```
git submodule add <repository-url>  # Add a submodule
```

### Q19: How do you list all remote branches?
**A:**
Use git branch -r to list all remote branches.

**Example:**
```
git branch -r  # List remote branches
```

### Q20: What is the purpose of git blame?
**A:**
git blame shows who last modified each line of a file and when.

**Example:**
```
git blame file.txt  # View line-by-line changes
```

### Q21: Explain which strategy is appropriate for different team sizes and release cadences.


## Submission Guidelines

*   Document your steps in `challenge_solution.md`, including:
    *   Screenshots of rebase/cherry-pick workflows.
    *   Diagrams explaining origin/upstream sync.
*   Push to GitHub and create a PR titled: **Day 4: Advanced Git Mastery**.
*   Share on LinkedIn with **#getfitwithsagar #DevOpsForAll**.

## Join the Community

Stuck? Connect with peers:

*   **Discord:** [Daily DevOps Challenges](https://discord.gg/mNDm39qB8t)
*   **YouTube:** [@Sagar.Utekar](https://youtube.com/@Sagar.Utekar)

Stay curious, keep breaking things (safely!), and happy coding!

**Best regards,**

Sagar Utekar
