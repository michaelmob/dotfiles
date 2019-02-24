# Mike Mob's Dotfiles
🇮 ❤️ 🐧



## Desktop Environment
| Program | Name | Description |
|---|---|---|
| Display Manager | [LightDM](https://www.freedesktop.org/wiki/Software/LightDM/) | Lightweight, cross-desktop display manager. |
| Window Manager | [i3](https://i3wm.org/) with [i3bar](https://i3wm.org/i3bar/) | Tiling window manager. |
| File Manager | [pcmanfm-qt](https://github.com/lxqt/pcmanfm-qt) and [lf](https://github.com/gokcehan/lf) | Graphical and console based file managers. |
| Clipboard Manager | [greenclip](https://github.com/erebe/greenclip) | Clipboard selections with rofi. |
| Screen Saver | [idlelock.sh](https://github.com/thetarkus/idlelock.sh) | Versatile auto-locking script. |
| Screen Locker | [i3lock](https://i3wm.org/i3lock/) with [besterlockscreen](https://github.com/thetarkus/besterlockscreen) | Fork of [betterlockscreen](https://github.com/pavanjadhaw/betterlockscreen) with wpgtk/pywal integration. |
| Theme Manager | [LXappearance](https://wiki.lxde.org/en/LXAppearance) and [wpgtk](https://github.com/deviantfero/wpgtk) | Theme, colorscheme and wallpaper manager. |
| Compositor | tryone144's fork of [Compton](https://github.com/tryone144/compton) | Compton with dual kawase blur. |
| Application Launcher | [Rofi](https://github.com/DaveDavenport/rofi) | Application launcher, alternative to dmenu. |
| Mount Tool | [udiskie](https://github.com/coldfix/udiskie) | An out-of-the-way device auto-mounter. |
| Notification Server | [Dunst](https://github.com/dunst-project/dunst) | Simple notification daemon. |



## Default Applications
Default applications can be changed by editing `~/.profile` or `~/.config/mimeapps.list`.

| Program | Name | Description |
|---|---|---|
| Terminal Emulator | [st](https://github.com/thetarkus/st) | My fork of the [suckless](https://suckless.org/) terminal. |
| Web Browser | [Firefox](https://www.mozilla.org/en-US/firefox/) | Web browser by [Mozilla](https://www.mozilla.org/). |
| Text Editor | [Neovim](https://neovim.io/) | Modal editor. Fork of [vim](https://www.vim.org/). |
| E-mail Client | [Thunderbird](https://www.thunderbird.net/en-US/) | E-mail client by [Mozilla](https://www.mozilla.org/). |
| Image Viewer | [sxiv](https://github.com/muennich/sxiv) | Simple X image viewer. |



## Fonts
| Font | Name | Location |
|---|---|---|
| Sans-Serif | [Roboto](https://fonts.google.com/specimen/Roboto) | `~/.config/fontconfig/conf.d/10-sans-serif.conf` |
| Monospace | [Roboto Mono](https://fonts.google.com/specimen/Roboto+Mono) | `~/.config/fontconfig/conf.d/10-mono.conf` |
| Emoji | [Twemoji](https://github.com/twitter/twemoji) | `~/.config/fontconfig/conf.d/99-emoji.conf` |


#### How to change fonts:
1. Install the font manually or by using your package manager (recommended).
2. Refresh your font cache: `fc-cache -f`
3. Check if your font is listed: `fc-list | grep 'Droid Sans'`
4. Name should be after the first colon.
5. Edit `~/.config/fontconfig/conf.d/10-sans-serif.conf` (or `10-mono.conf`, etc.), and replace the current font name with your new font.
6. Match for verification: `fc-match sans-serif` (or `monospace`, `serif`, etc.)

## Printers
Use the [cups](https://www.cups.org/) service to manage printers.
The web interface can be accessed [here](http://127.0.0.1:631/).

#### Enable cupsd
Something that should be automatically done during installation but is not.
```sh
sudo systemctl enable org.cups.cupsd.service
sudo systemctl start org.cups.cupsd.service
```

#### Allow yourself to add printers and print
Why is this even required?
```sh
# Find the line that starts with 'SystemGroup' and add your group there.
sudoedit /etc/cups/cups-files.conf

# Restart cupsd.service
sudo systemctl restart org.cups.cupsd.service
```

#### Allow non-root users (including you) to add printers
Who thought this was a good default?
```sh
# Find all occurences of CUPS-Add-Modify-Printer and then
# remove the line 'Require user @SYSTEM' from its block.
sudoedit /etc/cups/cupsd.conf

# Restart cupsd.service
sudo systemctl restart org.cups.cupsd.service
```
