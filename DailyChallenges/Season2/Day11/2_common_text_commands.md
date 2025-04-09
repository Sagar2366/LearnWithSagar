## Essential Tools for Managing Text File Contents
| Command | Explanation                                                                 |
|---------|-----------------------------------------------------------------------------|
| `less`  | Opens a file in a pager for easy reading and scrolling                      |
| `cat`   | Displays the entire file contents on the screen                             |
| `head`  | Shows the first few lines of a file (default: 10)                           |
| `tail`  | Shows the last few lines of a file (default: 10)                            |
| `cut`   | Filters specific columns or characters from a file                         |
| `sort`  | Sorts the file contents alphabetically or numerically                      |
| `wc`    | Counts lines, words, and characters in a file                               |

### Versatility with Pipes
These commands shine when paired with pipes:
- `less /etc/passwd`: View the `/etc/passwd` file.
- `ps aux | less`: Pipe process list output to `less` for scrollable reading.

---

## Mastering `less`
The `less` utility is a go-to tool for reading text files as a Linux admin.

### Usage
- Open a file: `less /etc/passwd`
- Navigate: Use **Page Up**/**Page Down** to scroll, press **`q`** to quit.
- Search:
  - Forward: `/sometext`
  - Backward: `?sometext`
  - Repeat: **`n`**

### Connection to `vim` and `man`
`less` shares navigation and search mechanics with `vim` and `man` due to their common code base.

> **Note:**  
> `less` was created to outdo `more`, a basic pager, inspiring the phrase "do more with less." Today, both tools have similar features, but `more` exits at file end (use `-p` to change this) and is standard everywhere, while `less` may require installation.

---

## Exercise 1: Applying Basic `less` Skills

### Objective

Practice using the `less` command to view and navigate through text files.

### Steps

1. **Open a File:**
Open the `/etc/passwd` file using `less`:

```bash
less /etc/passwd
```

2. **Search:**
Type `/root` to search for and highlight all occurrences of "root" in the file.
3. **Go to End:**
Press `G` to jump to the last line of the file.
4. **Quit:**
Press `q` to exit the `less` viewer.
5. **Pipe Output:**
Pipe the output of the `ps aux` command to `less` to browse the process list:

```bash
ps aux | less
```

## Showing File Contents with `cat`

### Overview

The `cat` command is a simple utility used to display the contents of a text file directly on the terminal screen. It is most suitable for short files, as it displays the entire file from start to finish without pausing.

### Using `cat`

1. **Basic Usage:**
To view the contents of a file, simply type `cat` followed by the filename:

```bash
cat filename.txt
```

2. **Example:**
To display the contents of the `/etc/passwd` file, use:

```bash
cat /etc/passwd
```


### Limitations

- **Long Files:** If the file is long, `cat` will display all contents, but only the lines that fit on the terminal screen will be visible. You might miss the beginning of the file as it scrolls by.
- **Viewing First Lines:** If you want to see the first lines of a long file, you can use the `tac` command, which displays the file in reverse order (from end to beginning).


### Alternatives

For longer files, consider using `less` or `more`, which allow you to view the file one page at a time and navigate through it more easily.

### Tip

- **Inverse Display:** Use `tac` to display a file in reverse order:

```bash
tac filename.txt
```

6. **Quit Again:**
Press `q` to exit the `less` viewer.


## Displaying First or Last Lines with `head` and `tail`

### Overview

The `head` and `tail` commands are used to display the beginning or end of a file, respectively. By default, they show the first or last ten lines of a file, but this can be adjusted.

### Using `head`

1. **Default Usage:**
To display the first ten lines of a file:

```bash
head filename.txt
```

2. **Specifying Number of Lines:**
To display a specific number of lines, use the `-n` option followed by the number:

```bash
head -n 5 filename.txt
# Or simply:
head -5 filename.txt
```


### Using `tail`

1. **Default Usage:**
To display the last ten lines of a file:

```bash
tail filename.txt
```

2. **Specifying Number of Lines:**
To display a specific number of last lines:

```bash
tail -n 2 filename.txt
# Or simply:
tail -2 filename.txt
```

3. **Following a File:**
The `-f` option displays the last ten lines and continues to display new lines as they are added to the file. This is useful for monitoring log files:

```bash
tail -f /var/log/messages
```

Press `Ctrl-C` to stop following the file.

### Combining `head` and `tail`

You can combine `head` and `tail` using pipes to extract specific lines from a file.

1. **Example:**
To display line number 11 of a file:

```bash
head -n 11 filename.txt | tail -n 1
```

This command first displays the first 11 lines and then extracts the last line from that output, which is line number 11 of the original file.


## Filtering Columns with `cut` and Sorting with `sort`

### Filtering Specific Columns with `cut`

#### Overview

The `cut` command is used to extract specific columns (fields) from a text file based on a delimiter.

#### Usage

```bash
cut -d &lt;delimiter&gt; -f &lt;field_number&gt; filename.txt
```

- `-d &lt;delimiter&gt;`: Specifies the delimiter that separates the fields.
- `-f &lt;field_number&gt;`: Specifies the field number to extract.


#### Example

To extract the first field (username) from the `/etc/passwd` file, where fields are delimited by a colon:

```bash
cut -d : -f 1 /etc/passwd
```


### Sorting File Contents with `sort`

#### Overview

The `sort` command is used to sort the lines of a text file.

#### Usage

```bash
sort filename.txt
```

- This sorts the file contents in byte order (ASCII order).


#### Sorting Output of a Command

You can sort the output of another command using a pipe:

```bash
cut -f 1 -d : /etc/passwd | sort
```

This extracts the first column from `/etc/passwd` and sorts the result.

#### Sorting Options

- `-n`: Sorts numerically.

```bash
cut -f 3 -d : /etc/passwd | sort -n
```

This sorts the third field of `/etc/passwd` in numeric order.
- `-r`: Sorts in reverse order.

```bash
du -h | sort -rn
```

This lists files sorted by size, with the largest file first.
- `-k column_number`: Specifies the column to sort.
- `-t delimiter`: Specifies the field separator.

```bash
sort -k3 -t : /etc/passwd
```

This sorts the `/etc/passwd` file by the third column, using ":" as the delimiter.


#### Example: Finding Busiest Processes

To sort processes by memory usage (4th column in `ps aux` output):

```bash
ps aux | sort -k 4 -n
```

This command displays processes sorted by memory usage, with the process using the least memory listed first.



