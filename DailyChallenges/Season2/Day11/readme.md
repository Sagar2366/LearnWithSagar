# Daily DevOps + SRE Challenge Series – Season 2
## Day 11: The Text File Takedown – Wrangle Logs and Configs Like a Pro

### Introduction
Welcome to Day 11 of the Daily DevOps + SRE Challenge Series – Season 2! 🎉

Today, you’re diving into the art of text file mastery—crucial for taming logs, tweaking configs, and slicing through data in Linux. You’ll wield powerful tools to read, filter, sort, and edit text, turning raw files into actionable insights. By the end, you’ll:
- Navigate and extract data from text files with ninja-like precision.
- Transform and analyze logs/configs using command-line magic.
- Build SRE-ready skills for debugging and automation.

#### Why This Matters?
Text files are the lifeblood of Linux systems—logs in `/var/log`, configs in `/etc`, scripts everywhere. Mastering them is non-negotiable:
- **Universal Power**: `grep`, `awk`, and `sed` work across clouds, containers, and bare metal—your Swiss Army knife for any system.
- **Automation Edge**: `tail -f /var/log/app.log | grep ERROR` feeds live alerts into monitoring scripts.
- **SRE Superpower**: During outages, `sort | uniq -c` on logs spots patterns fast; `sed` fixes configs on the fly.
- **Interview Gold**: “How do you find errors in a 1GB log?” or “Extract IPs from a file?”—you’ll ace these.
- **Real-World Save**: An SRE at a cloud provider used `awk '{print $1}' /var/log/access.log | sort | uniq -c` to pinpoint a DDoS source, throttling it in minutes.

Grab your terminal—it’s time to take down the text chaos!


In UNIX and Linux systems, configuration and information management have traditionally relied on plain-text files. Despite the availability of graphical tools today, editing these files manually with a text editor remains essential, especially for full system control and on servers without GUIs. Aspiring system administrators must learn to use text editors and tools like find (to locate files) and grep (to search within files) to manage and configure Linux systems effectively.

# vi/vim Cheat Sheet – Quick Reference

## Modes
| Mode            | Key         | Description                        |
|-----------------|-------------|------------------------------------|
| Command         | Default     | For navigation and actions         |
| Insert          | `i` / `a` / `o` | Enter insert mode (insert, append, open) |
| Return to Command | `Esc`     | Switch from insert to command mode |

## Insert Mode Commands
| Command | Description                     |
|---------|---------------------------------|
| `i`     | Insert before the cursor        |
| `a`     | Append after the cursor         |
| `I`     | Insert at the beginning of the line |
| `A`     | Append at the end of the line   |
| `o`     | Open new line below             |
| `O`     | Open new line above             |
| `Esc`   | Return to command mode          |

## Navigation
| Key         | Moves Cursor To               |
|-------------|-------------------------------|
| `h` / `l`   | Left / Right one character    |
| `j` / `k`   | Down / Up one line            |
| `w` / `W`   | Next word (by punctuation / space) |
| `b` / `B`   | Previous word                 |
| `0`         | Start of line                 |
| `$`         | End of line                   |
| `H`         | Top of screen                 |
| `M`         | Middle of screen              |
| `L`         | Bottom of screen              |
| `G`         | Last line of file             |
| `1G`        | First line of file            |
| `35G`       | Line 35                       |
| `Ctrl+f`    | Page forward                  |
| `Ctrl+b`    | Page backward                 |
| `Ctrl+d`    | Half page forward             |
| `Ctrl+u`    | Half page backward            |

## ✂️ Editing Text
| Command     | Description                       |
|-------------|-----------------------------------|
| `x` / `X`   | Delete character under / before cursor |
| `dd`        | Delete current line               |
| `dw`        | Delete word after cursor          |
| `db`        | Delete word before cursor         |
| `d$`        | Delete from cursor to end of line |
| `c + move`  | Change text (e.g., `c$` changes to end) |
| `cc`        | Change entire line                |
| `yy`        | Yank (copy) current line          |
| `y}`        | Yank paragraph                    |
| `p`         | Paste below/after                 |
| `P`         | Paste above/before                |
| `.`         | Repeat last change                |

## Searching
| Command          | Description                           |
|------------------|---------------------------------------|
| `/text`          | Search forward for "text"             |
| `?text`          | Search backward for "text"            |
| `n` / `N`        | Repeat search forward / backward      |
| `/The.*end`      | Regex: match “The” followed by “end”  |
| `?[Pp]rint`      | Case-insensitive search for “Print” or “print” |

## Ex Commands (use `:`)
| Command           | Description                           |
|-------------------|---------------------------------------|
| `:w`              | Save file                             |
| `:q`              | Quit if no unsaved changes            |
| `:wq` / `ZZ`      | Save and quit                         |
| `:q!`             | Quit without saving                   |
| `:s/old/new/`     | Replace first “old” with “new” in current line |
| `:g/old/s//new/g` | Replace all “old” with “new” in file  |
| `:g/old/s//new/gp`| Replace and print affected lines      |

## Pro Tips
| Command   | Description                           |
|-----------|---------------------------------------|
| `u`       | Undo last change                      |
| `Ctrl+r`  | Redo (undo the undo)                  |
| `:!command`| Run shell command (e.g., `:!date`, `:!ls`) |
| `Ctrl+G`  | Show filename, line number, and position |
