As a Linux user or administrator, you frequently interact with the filesystem to navigate, create, and manage files and directories. When you log into a Linux system and open a shell, you start in your **home directory** (e.g., `/home/joe`), which serves as your personal workspace for files and subdirectories. Mastering basic commands and file management techniques is essential for organizing data, securing access, and performing administrative tasks.

#### Home Directory

The home directory is represented by `~`, which is your default base (e.g., `/home/$USER`). You can use `~` to navigate to directories relative to your home directory.

### Core Filesystem Commands

These commands are the foundation for navigating and managing the filesystem.

#### 2.1 `cd` - Change Directory

- **Purpose**: Moves you to another directory.
- **Usage**:
    - `cd`: Returns to home (e.g., `/home/joe`).
    - **Absolute Path**: `cd /usr/share → /usr/share`. (Starts from the root directory `/`)
    - **Relative Path**: From `/usr/share`, `cd doc → /usr/share/doc`. (Relative to the current directory)
    - `cd ~`: Home directory (e.g., `/home/joe`).
    - `cd ~/Music`: Subdirectory of home (e.g., `/home/joe/Music`).
    - `cd ..`: Up one level (e.g., from `/usr/share/doc` to `/usr/share`).
    - `cd -`: Previous directory (`$OLDPWD`).
- **Key Concept**: `..` (parent) and `~` (home) simplify navigation.
- **Example**:

```bash
$ cd /usr/share/
$ pwd
/usr/share
$ cd doc
$ pwd
/usr/share/doc
$ cd
$ pwd
/home/chris
```


#### 2.2 `pwd` - Print Working Directory

- **Purpose**: Displays your current absolute path.
- **Usage**: `pwd → /home/joe`.
- **Use Case**: Confirms your location.


#### 2.3 `mkdir` - Make Directory

- **Purpose**: Creates directories.
- **Usage**:
    - `mkdir files`: Creates `files` in the current directory (e.g., `/home/joe/files`).
    - `mkdir -p /tmp/test/docs`: Creates nested directories if parents don’t exist.
- **Use Case**: Organizing files.


#### 2.4 `chmod` - Change Permissions

- **Purpose**: Sets file/directory permissions.
- **Usage**: `chmod 700 test → rwx------` (owner full access, others none).
- **Permissions**: `r` (4), `w` (2), `x` (1); `700 = 7` (owner), `0` (group), `0` (others).
- **Use Case**: Securing directories.


#### 2.5 `ls` - List Directory Contents

- **Purpose**: Shows files and directories.
- **Usage**:
    - `ls`: Non-hidden items.
    - `ls -l`: Long listing (e.g., `drwxr-xr-x 2 joe sales 1024 Jan 24 12:17 test`).
    - `ls -a`: Includes hidden files (e.g., `.hidden`).
    - `ls -lrt`: Sorts by time, reversed (recent last).
    - `ls -R`: Recursive listing.
    - `ls -d`: Directory info only (e.g., `ls -ld test`).
- **Note**: Colors may vary (e.g., blue for dirs, green for executables).


### File Management Tasks

Administrators perform key tasks to manage files effectively.

#### 3.1 Working with Wildcards

- **Purpose**: Match multiple files efficiently.
- **Wildcards**:


| Wildcard | Use |
| :-- | :-- |
| `*` | Refers to an unlimited number of any characters. `ls *` shows all files in the current directory (except those that have a name starting with a dot). |
| `?` | Used to refer to one specific character that can be any character. `ls c?t` would match `cat` as well as `cut`. |
| `[auo]` | Refers to one character that may be selected from the range that is specified between square brackets. `ls c[auo]t` would match `cat`, `cut`, and `cot`. |

- **Use Case**: `touch apple banana grape → ls *e* → apple, grape`.


#### 3.2 Absolute and Relative Pathnames

- **Absolute Pathname**: Complete path from the root directory `/` (e.g., `/home/lisa/file1`).
    - Always works, regardless of the current directory.
- **Relative Pathname**: Path relative to the current directory (e.g., from `/home`, `lisa/file1 → /home/lisa/file1`).
- When working with relative filenames, `..` moves up one level (e.g., from `/home/lisa`, `cp file1 ../lara` copies `/home/lisa/file1` to `/home/lara`).


#### 3.3 Listing Files and Directories

##### Detailed Explanation of `ls -la`

The command `ls -la` is a powerful tool for listing files and directories in Linux with detailed information. It combines two options:

- `-l`: Long listing format.
- `-a`: Show all files, including hidden files.

When you run `ls -la`, you get a detailed view of all files and directories, including those that are hidden (i.e., those whose names start with a dot `.`). This is incredibly useful for examining your system's configuration files and hidden directories.

##### Sample Output

```bash
$ ls -la /home/joe
total 158
drwxrwxrwx  2 joe   sales 4096 May 12 13:55 .
drwxr-xr-x  3 root  root  4096 May 10 01:49 ..
-rw-------  1 joe   sales 2204 May 18 21:30 .bash_history
-rw-r--r--  1 joe   sales   24 May 10 01:50 .bash_logout
-rw-r--r--  1 joe   sales  230 May 10 01:50 .bash_profile
-rw-r--r--  1 joe   sales  124 May 10 01:50 .bashrc
drw-r--r--  1 joe   sales 4096 May 10 01:50 .kde
-rw-rw-r--  1 joe   sales 149872 May 11 22:49 letter
```


##### Explanation of Columns

| Column | Description |
| :-- | :-- |
| 1 | **File type and permissions**: The first character indicates the file type (e.g., `d` for directory, `-` for file, `l` for symbolic link). The next nine characters represent permissions for the owner, group, and others. |
| 2 | **Number of hard links**: The number of hard links to the file or directory. |
| 3 | **Owner**: The owner of the file or directory. |
| 4 | **Group**: The group associated with the file or directory. |
| 5 | **Size**: The size of the file in bytes. For directories, it is typically 4096 bytes, representing the size of the directory metadata. |
| 6 | **Last modified**: The date and time when the file was last modified. |
| 7 | **Name**: The name of the file or directory. |

##### Key Details

* **. (Current Directory)**: Represents the current directory (`/home/joe` in this example).
* **.. (Parent Directory)**: Represents the directory above the current directory (`/home` in this example).
* **Hidden Files**: Files starting with a dot (`.`) are hidden files and are typically configuration files or directories used by applications.


##### Special Characters in Permissions

* **s (SetUID or SetGID)**: If you see an `s` instead of `x` in the permissions, it indicates a SetUID or SetGID program.
    * SetUID: Allows any user to run the application with the owner's permissions.
    * SetGID: Allows any user to run the application with the group's permissions.
* **t (Sticky Bit)**: If a `t` appears at the end of the permissions for a directory (e.g., `drwxrwxr-t`), it indicates the sticky bit is set.
    * Sticky Bit: Allows users to add files to the directory but prevents them from deleting files owned by others.
* **+ (Extended Attributes)**: If a `+` appears at the end of the permission bits (e.g., `-rw-rw-r--+`), it means that extended attributes, such as Access Control Lists (ACLs) or SELinux, are set on the file.


##### Examples and Best Practices

1. **Basic Usage**

```bash
$ ls -la ~
```

This command lists all files and directories in your home directory, including hidden ones, with detailed information.

2. **Checking Permissions**

```bash
$ ls -la /etc/passwd
```

Use this to check the permissions, owner, and group of the `/etc/passwd` file.

3. **Troubleshooting**
If you're missing configuration files, running `ls -la` will show you if they exist and what their permissions are.


#### 3.4 Copying Files and Directories

- **Command**: `cp source dest;`.
- **Purpose**: The `cp` command allows you to copy files and directories from one location to another.
- **Basic Usage**:
    - To copy a single file:

```bash
cp /path/to/source/file /path/to/destination/
```

    - Example:

```bash
cp /etc/hosts /tmp/
```

This copies the file `/etc/hosts` to the `/tmp/` directory.
- **Options**:


| Option | Description |
| :-- | :-- |
| `-R` | Recursive: Copies directories and their contents recursively. |
| `-a` | Archive: Preserves file attributes (permissions, ownership, timestamps). It is equivalent to `-dpR`. |
| `-i` | Interactive: Prompts before overwriting existing files. |
| `-u` | Update: Copies only when the source file is newer than the destination file or when the destination file is missing. |
| `-v` | Verbose: Shows the files being copied. |

- **Important Considerations**:
    - **Target Directory**: Always ensure the target directory exists.  If you copy a file to a non-existent directory without a trailing `/`, it will create a file named as the directory instead.

```bash
cp /etc/hosts /tmp # If /tmp doesn't exist, it creates a file named 'tmp'
cp /etc/hosts /tmp/ # Correct way, ensures /tmp is treated as a directory
```

    - **Copying Directories Recursively**:
To copy an entire directory, use the `-R` option.

```bash
cp -R /etc /tmp
```

This copies the `/etc` directory and all its contents to the `/tmp` directory.
    - **Preserving Attributes**:
To keep the original file permissions and other attributes, use the `-a` option (archive mode).

```bash
cp -a ~ /tmp
```

This copies your entire home directory to the `/tmp` directory while preserving all file attributes.
    - **Hidden Files**:
Hidden files (files starting with `.`) are not copied by default. Here's how to handle them:

1. **Using `.*`**:

```bash
cp /somedir/.* /tmp
```

This copies hidden files from `/somedir/` to `/tmp`. Note that this will produce an error for the `.` and `..` directories unless you use the `-R` option.
2. **Copying the entire directory**:

```bash
cp -a /somedir/ .
```

This creates a `somedir` subdirectory in the current directory and copies all contents, including hidden files.
3. **Copying all files, including hidden files, into the current directory**:

```bash
cp -a /somedir/. .
```

Make sure there is a space between the two dots. This copies all files and directories (including hidden ones) from /somedir into the current directory.


### Best Practices and Tips

- Ensure the destination directory exists to avoid creating a file instead of copying into a directory.
- Use the -a option when you want to preserve file attributes like permissions and timestamps.
- Be cautious when using wildcards, and always double-check your command before executing to avoid unintended consequences.



#### 3.5 Moving Files and Directories

- **Command**: `mv source dest`.
- **Usage**:
    - `mv file1 /tmp`: Moves to `/tmp`.
    - `mv file1 file2`: Renames.
    - `mv dir /tmp`: Moves directory (works with contents).
- **Note**: Combines copy and delete.


#### 3.6 Deleting Files and Directories

- **Command**: `rm target;`.
- **Usage**:
    - `rm file1`: Deletes a file.
    - `rm -r dir`: Deletes directory recursively.
    - `rm -f`: Forces without prompting.
- **Note**: On RHEL, `rm` may alias to `rm -i` (prompts for confirmation); use `-f` to override.


### Metacharacters and Operators

- **Brace Expansion**: `touch memo{1,2,3} → memo1 memo2 memo3`.
- **Redirection**:
    - `&gt;`: Overwrites file (e.g., `echo "test" &gt; file`).
    - `&gt;&gt;`: Appends (e.g., `echo "more" &gt;&gt; file`).
    - `&lt;`: Input from file (e.g., `mail root &lt; file`).
    - `&lt;&lt;WORD`: Here document (e.g., `cat &lt;&lt;END`).


### Practical Context

- **Workflow**: `cd ~; mkdir test; chmod 700 test; cp -a test /tmp; rm -r /tmp/test`.
- **Permissions**: `ls -l` shows owner, group, and access (e.g., `rwxr-xr-x`).
- **Hidden Files**: Start with `.` (e.g., `.hidden`), visible with `ls -a`.


### Why This Matters

- **Foundation**: Essential for Linux administration and scripting.
- **Efficiency**: Wildcards and operators save time.
- **DevOps/SRE**: Critical for server management and automation.
- **RHCSA**: Tests these skills explicitly.


### Key Takeaways for Learners

- Navigate with `cd`, `pwd`.
- Create with `mkdir`, `touch`.
- Manage files with `cp`, `mv`, `rm`; secure with `chmod`.
- Use wildcards (`*`, `?`, `[]`) and paths (absolute/relative) for flexibility.
- List with `ls` variations (e.g., `-l`, `-a`, `-R`, `-d`).
- Understand permissions and file types via `ls -l`.
