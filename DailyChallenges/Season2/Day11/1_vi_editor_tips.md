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
