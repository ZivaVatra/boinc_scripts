# boinc_scripts
A collection of scripts to batch manage multiple projects from the commandline.

The libraries/functions are as follows:

- Bash functions script, you can source it into your shell, then the boinc_ commands can be used to do batch operations on all specified projects

- Python library. A WIP for allowing integration into other python programs/scripts

Scripts using the library:

- suspend_if_gpu_over_temp.sh  (NVidia only. Uses nvidia-smi to monitor the GPU temp, and if it reaches a set temp it will suspend execution and wait a set time). Also assumes you use "fancontrol" to allow software control of case fans, but script will still work if you don't.
