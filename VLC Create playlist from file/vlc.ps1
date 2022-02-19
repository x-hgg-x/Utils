Param([string]$filename)

# kill other instances of vlc to keep playlist clean (one-instance mode)
Stop-Process -Name vlc -ErrorAction SilentlyContinue

$vlcPath = "C:\Program Files (x86)\VideoLAN\VLC\vlc.exe"
$Extensions='(\.avi$|\.mp4$|\.mkv$|\.m4v$|\.mov$|\.mpg$|\.mpeg$|\.wmv$|\.ogg$|\.flac$|\.m4a$|\.mp3$|\.wav$)'

if ([string]::IsNullOrEmpty($filename)) {& $vlcPath; exit} # launch empty vlc if no argument provided

# parse argument
$filename = Resolve-Path -LiteralPath $filename
$dirname = Split-Path -LiteralPath $filename
$basename = Get-ChildItem -LiteralPath $filename | ForEach-Object { $_.Name }

# count files with matching extension, and get position of filename in current directory
$filelist = Get-ChildItem -File -LiteralPath $dirname | ForEach-Object { $_.Name } | Select-String -Pattern $Extensions | ForEach-Object { $_.Line }
$count = $($filelist | Measure-Object -Line).Lines
$position = $filelist | Select-String -SimpleMatch $basename | ForEach-Object { $_.LineNumber }

# if the filename does not have one of the extension above, launch vlc with provided filename
if ([string]::IsNullOrEmpty($position)) {& $vlcPath $filename; exit}

# change positions in playlist such as the first element is the opened file
$filelist | Select-Object -last ($count-$position+1) | ForEach-Object { "$dirname\" + $_ } >  $Env:TMP\vlc.m3u
$filelist | Select-Object -first ($position-1)       | ForEach-Object { "$dirname\" + $_ } >> $Env:TMP\vlc.m3u

# launch playlist
& $vlcPath $(Get-Content $Env:TMP\vlc.m3u)
