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

- **Enhanced `ls` Options**:
    - `ls -a`: Shows hidden files (e.g., `.bashrc`). Hidden files start with a dot (`.`).
    - `ls -lrt`: Recent files last.
    - `ls -F`: Adds indicators (`/` for dirs, `*` for executables, `@` for links).
    - `ls -d`: Shows the names of directories, not the contents of all directories that match the wildcards.
    - `ls -R`: Shows the contents of the current directory and all its subdirectories recursively.
- **Permissions**: `drwxr-xr-x` (dir, owner `rwx`, group `rx`, others `rx`).


#### 3.4 Copying Files and Directories

- **Command**: `cp &lt;source&gt; &lt;dest&gt;`.
- **Usage**:
    - `cp /etc/hosts /tmp`: Copies `hosts` to `/tmp`.
    - `cp -R /etc /tmp`: Copies directory recursively.
    - `cp -a ~ /tmp`: Preserves permissions (archive mode).
- **Hidden Files**:
    - `cp /somedir/.* /tmp`: Copies hidden files only.
    - `cp -a /somedir/. .`: Copies all (hidden + regular) to the current directory.
- **Tip**: Use trailing `/` (e.g., `/tmp/`) to ensure the destination is a directory.


#### 3.5 Moving Files and Directories

- **Command**: `mv &lt;source&gt; &lt;dest&gt;`.
- **Usage**:
    - `mv file1 /tmp`: Moves to `/tmp`.
    - `mv file1 file2`: Renames.
    - `mv dir /tmp`: Moves directory (works with contents).
- **Note**: Combines copy and delete.


#### 3.6 Deleting Files and Directories

- **Command**: `rm &lt;target&gt;`.
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
