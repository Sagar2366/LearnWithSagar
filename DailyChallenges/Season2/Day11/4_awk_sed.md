## Working with Other Useful Text Processing Utilities

### Overview

Besides `grep`, `awk` and `sed` are powerful utilities for text processing, particularly useful in scripted environments where direct screen interaction is limited.

### `awk`

#### Overview

`awk` is a versatile utility for text processing, capable of more complex field extraction than `cut`.

#### Usage

```bash
awk -F delimiter '{ print $column_number }' filename
```

- `-F delimiter`: Specifies the field delimiter.
- `'{ print $column_number }'`: Specifies the column to print.


#### Examples

1. **Printing the fourth field from `/etc/passwd`**:

```bash
awk -F : '{ print $4 }' /etc/passwd
```

2. **Searching for text and printing a field**:

```bash
awk -F : '/user/ { print $4 }' /etc/passwd
```

    * Searches `/etc/passwd` for lines containing "user" and prints the fourth field of matching lines.

### `sed`

#### Overview

`sed` (stream editor) is used for filtering and modifying text in files.

#### Usage

1. **Printing a specific line**:

```bash
sed -n line_number;p filename
```

    * `-n`: Suppresses default output.
    * `p`: Print command.

Example:

```bash
sed -n 5p /etc/passwd
```

    * Prints the fifth line from `/etc/passwd`.
2. **Replacing text in a file**:

```bash
sed -i 's/old-text/new-text/g' filename
```

    * `-i`: Modifies the file directly.
    * `s/old-text/new-text/g`: Substitutes all occurrences of `old-text` with `new-text`.

Example:

```bash
sed -i 's/old-text/new-text/g' ~/myfile
```

    * Replaces all occurrences of "old-text" with "new-text" in `~/myfile`.
3. **Deleting lines by line number**:

```bash
sed -i -e 'line_number;d' filename
```

    * `-e`: Specifies an editing command.
    * `d`: Delete command.

Example:

```bash
sed -i -e '2d' ~/myfile
```

    * Deletes line 2 from `~/myfile`.
4. **Deleting multiple lines**:

```bash
sed -i -e '2d;20,25d' ~/myfile
```

    * Deletes line 2 and lines 20 through 25 in `~/myfile`.
