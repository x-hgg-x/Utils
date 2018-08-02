# Nemo save and restore session

Execute nemo_save.sh to save list of opened nemo windows in ~/nemo.dat.

Launch nemo_restore.sh to reopen saved list of windows.

Restrictions : the script cannot save opened tabs, and won't save a folder whose name is too long. For special folders like Trash, you can replace the window title name in nemo_save.sh if you know the full path.
