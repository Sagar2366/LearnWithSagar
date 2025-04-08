## Recalling Commands Using Command History  

Repeating or modifying commands from your shell session is a powerful way to save time and effort. The Bash shell provides a **command history** feature that stores commands you’ve entered, allowing you to recall, edit, and reuse them. This is especially handy for correcting typos in long commands or reusing complex pipelines without retyping.  

---

### **Understanding the History List**  
The shell maintains a list of your previous commands, accessible via the `history` command:  
**View History:**  
  ```bash
  history
  ```
Displays all stored commands (up to a default of 1,000, configurable via HISTSIZE).

**Limit Output:**
```bash
history 10
```
Shows the last 10 commands, each prefixed with a number (e.g., 382 date).

**Storage:** Commands are held in memory during the session and saved to ~/.bash_history upon exit.
**Example Output:**

  ```bash
382  date
383  ls /usr/bin | sort -f | less
384  history 10
```

### **Command-Line Editing in Bash**
Bash lets you edit recalled commands instead of starting from scratch.
By default, it uses Emacs-style key bindings, but you can switch to Vi-style for a different experience.

**Set Vi Mode**
Add the following to your ~/.bashrc file:

  ```bash
set -o vi
Then, reload your shell:

  ```bash
source ~/.bashrc
```
**In Vi mode:** Press Esc to enter command mode, then use Vi keys (e.g., i to insert).

**Emacs Editing Example**
**Modify this command:**

  ```bash
ls /usr/bin | sort -f | less
```

**To:**

  ```bash
ls /bin | sort -f | less
```

**Steps:**
Press ↑ (up arrow) to recall the previous command.

Press Ctrl+A to move to the start of the line.

Press Ctrl+F (or →) to move under the first /.

Press Ctrl+D four times to delete /usr.

Type bin, then press Enter.


<img width="559" alt="Screenshot 2025-04-08 at 8 03 36 AM" src="https://github.com/user-attachments/assets/d899fedf-03cb-47e6-a08b-c78a5ecc8887" />
