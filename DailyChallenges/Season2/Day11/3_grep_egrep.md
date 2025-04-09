## Using `grep` to Analyze Text

### Overview

`grep` (Global Regular Expression Parser) is a powerful utility for searching plain-text data using regular expressions. It works on files or command outputs.

### Key Features

- **Case-sensitive by default**
- **Can search files, directories, and command output**
- **Supports regular and extended regular expressions**
- **Highlights matches using `--color`**

---

### Commonly Used Options

| Option | Description |
| :-- | :-- |
| `-i` | Case-insensitive matching |
| `-v` | Invert match (show lines that do **not** match) |
| `-r` | Recursively search directories |
| `-l` | Print only filenames with matches |
| `-e` | Use multiple regex patterns |
| `-E` | Interpret pattern as an extended regular expression |
| `-A N` | Show N lines *after* each match |
| `-B N` | Show N lines *before* each match |
| `--color` | Highlight the matching text |

---

### Practical Examples

#### 1. **Simple Match in File**

```bash
grep desktop /etc/services
```

* Matches exact lowercase `desktop`.


#### 2. **Case-Insensitive Match**

```bash
grep -i desktop /etc/services
```

* Matches variations like `Desktop`, `DESKTOP`, etc.


#### 3. **Exclude Matches**

```bash
grep -vi tcp /etc/services
```

* Show all lines **except** those containing `tcp`.


#### 4. **Recursive Search (Case-Insensitive)**

```bash
grep -rli peerdns /usr/share/doc/
```

* Search recursively for `peerdns`, show filenames only.


#### 5. **Recursive Search with Highlight**

```bash
grep -ri --color root /etc/sysconfig/
```

* Highlights `root` in red (by default) wherever it appears.


#### 6. **Filter Output of Another Command**

```bash
ip addr show | grep inet
```

* Shows only lines with `inet`, useful for filtering IP addresses.

---

### Filtering Comments and Blank Lines

```bash
grep -v -e '^#' -e '^$' /etc/services
```

* Removes comment lines (`#`) and empty lines.

---

### Finding lines starting with a comment (`#`)**:

```bash
grep ' #' /etc/services
```

### Excluding lines starting with a comment**:

```bash
grep -v '^#' /etc/services
```

* Shows only lines that do not start with `#`.
### Showing lines before matches**:

```bash
grep -v '^#' /etc/services -B 5
```
* Shows lines that do not start with `#`, along with the 5 lines before each match.
    
## Tips

- Combine `grep` with `sort`, `uniq`, and `wc` for powerful text processing.
- Use double quotes for patterns with spaces or variables: `grep "$pattern" file.txt`.
- Use `^` and `$` to anchor searches to the beginning or end of lines.



## Using Extended Regular Expressions (EREs)

### Overview

Extended Regular Expressions (EREs) provide additional features compared to basic regular expressions. Tools like `grep` require the `-E` option to recognize EREs.

### Key ERE Features

| Regular Expression | Use |
| :-- | :-- |
| `^text` | Matches a line that starts with the specified text. |
| `text$` | Matches a line that ends with the specified text. |
| `.` | Wildcard: Matches any single character. |
| `[abc]` | Matches `a`, `b`, or `c`. |
| `?` | Matches zero or one occurrence of the preceding character. |
| `+` | Matches one or more occurrences of the preceding character. |
| `*` | Matches zero to an infinite number of occurrences of the preceding character. |
| `\{2\}` | Matches exactly two occurrences of the preceding character. |
| `\{1,3\}` | Matches a minimum of one and a maximum of three occurrences of the preceding character. |
| `colou?r` | Matches zero or one of the previous character. Matches both "color" and "colour". |
| `(...)` | Groups multiple characters so that the regular expression can be applied to the group. |

### Examples and Usage

1. **Enabling ERE with `grep`**:
    * Use `grep -E` to interpret patterns as extended regular expressions.
2. **Example Regular Expression**:
    * `"/web(/.*)?"`
    * Matches `/web`, `/web/`, or `/web/filename`.

### Demonstrating ERE with `grep`

1. **Create a text file named `regex.txt`**:

```text
bat
boot
boat
bt
```

2. **Base Regular Expression**:

```bash
grep 'b.*t' regex.txt
```

    * Finds any line that starts with `b` and ends with `t`.
3. **Extended Regular Expression (Incorrect)**:

```bash
grep 'b.+t' regex.txt
```

    * Without the `-E` option, `grep` does not correctly interpret the `+`.
4. **Extended Regular Expression (Correct)**:

```bash
grep -E 'b.+t' regex.txt
```

    * Finds lines that have at least one character between `b` and `t`.



### Examples and Usage




