# VLC Create playlist from file

These scripts make VLC behave like MPC-HC, ie when you open a file with VLC in a folder,
it will automatically add all the files in this folder to the playlist (starting with the opened file, then sorted alphabetically),
so that you can use Previous and Next to navigate through the folder.

## Usage

### Windows

Copy vlc.ps1 and vlc.bat in your home directory, then you can open your video/audio file with vlc.bat like this :

``` vlc.bat video.mp4```.

You may want to run ```Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy UNRESTRICTED``` once in a powershell terminal
to allow exectution of powershell scripts.

You can check if the variable ```$vlcPath``` is correct in vlc.ps1, and modify known extensions with the variable ```$Extensions```.

### Linux

Copy vlc.sh in your home directory and mark it executable, then copy the desktop file of VLC ```/usr/share/applications/vlc.desktop``` to ```~/.local/share/applications/vlc.desktop``` and change the field ```Exec``` to the path of vlc.sh (remove argument ```--started-from-file %U```). Known extensions are stocked in variable ```$extensions```.

You may want to activate the loop option in VLC preferences if VLC is configured to play the next track automatically.

## Notes

Due to internal behaviour of VLC, you cannot replace current playlist by another, only append it. Therefore the script must kill existing instances of VLC to launch a new playlist, so it works only when VLC is in one-instance mode. 

