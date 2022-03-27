# IPython Startup

This is the IPython startup directory `.py` and `.ipy` files in this directory will be run *prior* to any code or files specified
via the exec_lines or exec_files configurables whenever you load this profile.

Files will be run in lexicographical order, so you can control the execution order of files with a prefix, for example:

1. 00-first.py
2. 50-middle.py
3. 99-last.ipy
