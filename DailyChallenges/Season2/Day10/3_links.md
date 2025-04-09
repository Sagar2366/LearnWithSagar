# Using Links

Links on Linux are like aliases assigned to a file. There are symbolic links and hard links. To understand a link, you need to know how the Linux filesystem uses inodes for filesystem administration.

### Understanding Hard Links

Linux stores administrative data about files in inodes. The inode stores all administrative data about files. Every file on Linux has an inode, and important information is stored in it:

* The data block where the file contents are stored
* The creation, access, and modification date
* Permissions
* File owners

The filename is not stored in the inode; names are stored in the directory. Each filename knows which inode it has to address to access further file information. An inode knows how many names are associated with it; these names are referred to as **hard links**. Every file always has one hard link to start with, which is the name of the file. When you create a file, you are creating a hard link. On a Linux filesystem, multiple hard links can be created to a file, which is useful if a file with the same contents needs to be available at multiple locations. If a change is applied to any one of the hard links, it will show in all other hard links because all hard links point to the same data blocks.

Restrictions for hard links:

* Hard links must exist all on the same device (partition, logical volume, etc.).
* You cannot create hard links to directories.

When the last hard link to a file is removed, access to the file’s data is also removed. There is no difference between the first hard link and the second hard link; they are both just hard links.

#### Inode Diagram

Here's a simple representation of how hard links and inodes work:

    +----------+     +---------+
    | Directory| --; |  Inode  | --; Data Blocks (File Content)
    +----------+     +---------+
         ^
         |
    +----------+
    |Hard Link |
    +----------+
    
### Understanding Symbolic Links

A **symbolic link** (also referred to as a soft link) does not link directly to the inode but to the name of the file. This makes symbolic links more flexible but has some disadvantages. The advantage of symbolic links is that they can link to files on other devices and directories. The major disadvantage is that when the original file is removed, the symbolic link becomes invalid.

#### Symbolic Link Diagram

    +----------+     +--------------+     +----------+     +---------+
    |Directory | --; | Symbolic Link| --; |Directory | --; |  Inode  | --; Data Blocks
    +----------+     +--------------+     +----------+     +---------+
                   (Points to name)
    
### Creating Links

Use the `ln` command to create links. It uses the same order of parameters as `cp` and `mv`; first, you mention the source name, followed by the destination name. If you want to create a symbolic link, use the option `-s`, and then specify the source and target file or directory. One important restriction applies: to be able to create hard links, you must be the owner of the item that you want to link to.


| Command | Explanation |
| :-- | :-- |
| `ln /etc/hosts .` | Creates a hard link to the file `/etc/hosts` in the current directory |
| `ln -s /etc/hosts .` | Creates a symbolic link to the file `/etc/hosts` in the current directory |
| `ln -s /home /tmp` | Creates a symbolic link to the directory `/home` in the directory `/tmp` |

The `ls` command will reveal whether a file is a link:

* In the output of the `ls -l` command, the first character is an `l` if the file is a symbolic link.
* If a file is a symbolic link, the output of `ls -l` shows the name of the item it links to after the filename.
* If a file is a hard link, `ls -l` shows the hard link counter.

[root@localhost tmp]\# \ls -l
total 3
lrwxrwxrwx. 1 root root 5 Jan 19 04:38 home -> /home
-rw-r--r--. 3 root root 158 Jun 7 2013 hosts

In the example above, `home` is a symbolic link pointing to `/home`, and `hosts` is a file with 3 hard links.

### Removing Links

Removing links can be dangerous. Let’s consider the following procedure:

1. Make a directory named `test` in your home directory: `mkdir ~/test`
2. Copy all files that have a name starting with a, b, c, d, or e from `/etc` to this directory: `cp /etc/[a-e]* ~/test`
3. Type `ls -l ~/test/` to verify the contents of the `test` directory.
4. Make sure that you are in your home directory, by using `cd` without arguments.
5. Type `ln -s test link`
6. Type `rm link`. This removes the symbolic link. (Do not use `-r` or `-f` to remove symbolic links, even if they are subdirectories.)
7. Type `ls -l`. You’ll see that the symbolic link has been removed.
8. Let’s do it again. Type `ln -s test link` to create the link again.
9. Type `rm -rf link/` (which is what you would get by using Bash command-line completion).
10. Type `ls`. You’ll see that the directory `link` still exists.
11. Type `ls test/`. You’ll see the directory `test` is now empty.

### 1Exercise: Working with Symbolic Links and Hard Links

1. Open a shell as the `student` user.
2. From your home directory, type `ln /etc/passwd .` (Make sure that the command ends with a dot that has a space before it!). This command gives you an “operation not permitted” error because you are not the owner of `/etc/passwd`.
3. Type `ln -s /etc/passwd .` (Again, make sure that the command ends with a space and a dot!). This works; you do not have to be the owner to create a symbolic link.
4. Type `ln -s /etc/hosts` (this time with no dot at the end of the command). You’ll notice this command also works. If the target is not specified, the link is created in the current directory.
5. Type `touch newfile` and create a hard link to this file by using `ln newfile linkedfile`.
6. Type `ls -l` and notice the link counter for `newfile` and `linkedfile`, which is currently set to `2`.
7. Type `ln -s newfile symlinkfile` to create a symbolic link to `newfile`.
8. Type `rm newfile`
9. Type `cat symlinkfile`. You will get a “no such file or directory” error message because the original file could not be found.
10. Type `cat linkedfile`. This gives no problem.
11. Type `ls -l` and look at the way the `symlinkfile` is displayed. Also, look at `linkedfile`, which now has the link counter set to `1`.
12. Type `ln linkedfile newfile`
13. Type `ls -l` again. You’ll see that the original situation has been restored.
