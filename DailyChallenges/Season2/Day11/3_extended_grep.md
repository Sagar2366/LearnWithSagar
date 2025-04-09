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

## Using `grep` to Analyze Text

### Overview

`grep` (Global Regular Expression Parser) is a powerful utility for searching text using regular expressions.

### Useful `grep` Options

| Option | Use |
| :-- | :-- |
| `-i` | Matches upper- and lowercase letters (case-insensitive). |
| `-v` | Shows only lines that do *not* contain the regular expression. |
| `-r` | Searches files in the current directory and all subdirectories. |
| `-e` | Searches for lines matching more than one regular expression. Use `-e` before each regular expression. |
| `-E` | Interprets the search pattern as an extended regular expression. |
| `-A number` | Shows `&lt;number&gt;` of lines *after* the matching regular expression. |
| `-B number` | Shows `&lt;number&gt;` of lines *before* the matching regular expression. |

### Examples and Usage

1. **Finding lines starting with a comment (`#`)**:

```bash
grep ' #' /etc/services
```

2. **Excluding lines starting with a comment**:

```bash
grep -v '^#' /etc/services
```

    * Shows only lines that do not start with `#`.
3. **Showing lines before matches**:

```bash
grep -v '^#' /etc/services -B 5
```

    * Shows lines that do not start with `#`, along with the 5 lines before each match.
4. **Excluding comments and blank lines**:

```bash
grep -v -e '^#' -e '^$' /etc/services
```

    * Excludes all blank lines and lines that start with `#`.


