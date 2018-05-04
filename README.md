# gopro-rename

[![Build Status](https://travis-ci.org/AMDmi3/gopro-rename.svg?branch=master)](https://travis-ci.org/AMDmi3/gopro-rename)
[![Codacy Badge](https://api.codacy.com/project/badge/Grade/bb9c96a4c5d548a893b0955e1893234d)](https://www.codacy.com/app/AMDmi3/gopro-rename)

[GoPro](https://gopro.com) action cameras have totally inconvenient [file naming convention](https://gopro.com/support/articles/hero3-and-hero3-file-naming-convention), which is, for instance, completely unfriendly to sorting. Example:

```
GOPR0001.MP4 # video 1 start
GOPR0002.MP4
GOPR0003.MP4
GP010001.MP4 # video 1 continued
GP010002.MP4
GP010003.MP4
GP020001.MP4 # video 1 last part
```

This script renames files an a more sane way:

```
GoPro_0001_00.MP4 # video 1 start
GoPro_0001_01.MP4 # video 1 continued
GoPro_0001_02.MP4 # video 1 last part
GoPro_0002_00.MP4
GoPro_0002_01.MP4
GoPro_0003_00.MP4
GoPro_0003_01.MP4
```

## Usage

```
gopro-rename [-nfvr] [-d | [-p prefix]] path [path ...]
```

The program takes arbitrary number of paths as arguments. If file
path is given, it's processed directly, if directory path is given,
all files in the given directory are processed (by default the
script does not ascend into subdirectories, but this behavior may
be changed by **-r** flag). Processing involves checking whether a
file name looks like it has been produced by GoPro and renaming the
file (unless **-n** flag was specified).
The default file prefix is "GoPro_", however this can be overridden
with either the directory name (using the **-d** flag) or specific text
(using the **-p** flag). The files which do not match GoPro file naming
convention are silently ignored.

Additional flags:

* **-n**, **--dry-run** - do not rename files, just print renames to stderr
* **-f**, **--force** - rename file even if destination path exists
* **-v**, **--verbose** - print performed renames to stderr
* **-r**, **-R**, **--recursive** - process subdirectories recursively
* **-d**, **--directory** - use the directory name as filename prefix instead of the default. Cannot be used with --prefix option.
* **-p**, **--prefix** - set the filename prefix instead of the default. Cannot be used with --directory option.

Example of **-d** option with directory name of 'testDir'

```
testDir\GOPR0001.MP4 # video 1 start
testDir\GOPR0002.MP4
testDir\GOPR0003.MP4
testDir\GP010001.MP4 # video 1 continued
testDir\GP010002.MP4
testDir\GP010003.MP4
testDir\GP020001.MP4 # video 1 last part
```

Files are renamed as follows:

```
testDir\testDir_0001_00.MP4 # video 1 start
testDir\testDir_0001_01.MP4 # video 1 continued
testDir\testDir_0001_02.MP4 # video 1 last part
testDir\testDir_0002_00.MP4
testDir\testDir_0002_01.MP4
testDir\testDir_0003_00.MP4
testDir\testDir_0003_01.MP4
```

## Requirements

Only python interpreter is required, both python 2.x and 3.x are supported

## Author

* [Dmitry Marakasov](https://github.com/AMDmi3) <amdmi3@amdmi3.ru>

## Contributors

* [Manu Erwin](https://github.com/manuerwin)

## License

MIT, see COPYING.
