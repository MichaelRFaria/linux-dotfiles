https://github.com/Almamu/linux-wallpaperengine

Assets from a legitimate version of Wallpaper Engine must be copied into this directory:
1. In Steam, right-click Wallpaper Engine → Manage → Browse local files
2. Copy the assets folder to this directory

Wallpapers from Steam workshop must be copied into this directory:
1. Locate Wallpaper Engine's workshop directory at `...\Steam\steamapps\workshop\content\431960`
2. All subdirectories are workshop items representing different wallpapers named by workshop id, copy them into here

linux-wallpaperengine is ran automatically by `systemd/linux-wallpaperengine.service`, changes to the wallpaper must be made there.
    To set/change a wallpaper you would add the path to the wallpaper directory after the `-bg` option
        e.g: `... --bg /home/michael/.config/linux-wallpaperengine/1160870304 ...`
