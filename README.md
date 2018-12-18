# Mike Mob's Dotfiles
🇮 ❤️ 🐧



## Desktop Environment
| Program | Name | Description |
|---|---|---|
| Display Manager | [LightDM](https://www.freedesktop.org/wiki/Software/LightDM/) | Lightweight, cross-desktop display manager. |
| Window Manager | [i3](https://i3wm.org/) with [i3bar](https://i3wm.org/i3bar/) | Tiling window manager. |
| Power Manager | [Hypersomnia](https://github.com/thetarkus/hypersomnia) | Desktop-Environment Agnostic Lock and Sleep Tool. |
| File Manager | [ranger](https://github.com/ranger/ranger) | Vim-inspired file manager. |
| Screen Locker | [i3lock](https://i3wm.org/i3lock/) with [besterlockscreen](https://github.com/thetarkus/besterlockscreen) | Fork of [betterlockscreen](https://github.com/pavanjadhaw/betterlockscreen) with wpgtk/pywal integration. |
| Theme Manager | [LXappearance](https://wiki.lxde.org/en/LXAppearance) and [wpgtk](https://github.com/deviantfero/wpgtk) | Theme, colorscheme and wallpaper manager. |
| Compositor | tryone144's fork of [Compton](https://github.com/tryone144/compton) | Compton with dual kawase blur. |
| Application Launcher | [Rofi](https://github.com/DaveDavenport/rofi) | Application launcher, alternative to dmenu. |
| Mount Tool | [udiskie](https://github.com/coldfix/udiskie) | An out-of-the-way device auto-mounter. |
| Notification Server | [Dunst](https://github.com/coldfix/udiskie) | Simple notification daemon. |



## Default Applications
Default applications can be changed by editing `~/.profile` or `~/.config/mimeapps.list`.

| Program | Name | Description |
|---|---|---|
| Browser | [Brave]() | Fast, freedom-respecting web browser. |
| Editor | [Vim]() | Modal editor. |
| Password Manager | [Bitwarden](https://bitwarden.com/) | Open-source password manager. |
| E-mail | [Thunderbird](https://www.thunderbird.net/en-US/) | E-mail client by Mozilla. |



## Fonts
| Font | Name | Location |
|---|---|---|
| Sans-Serif | [Droid Sans](https://fonts.google.com/?query=droid&selection.family=Cardo) | `~/.config/fontconfig/conf.d/10-sans-serif.conf` |
| Monospace | [Hack](https://github.com/source-foundry/Hack) | `~/.config/fontconfig/conf.d/10-mono.conf` |
| Emoji | [Twemoji](https://github.com/twitter/twemoji) | `~/.config/fontconfig/99-emoji.conf` |


### How to change fonts:
1. Install the font manually or by using your package manager (recommended).
2. Refresh your font cache: `fc-cache -f`
3. Check if your font is listed: `fc-list | grep 'Droid Sans'`
4. Name should be after the first colon.
5. Edit `~/.config/fontconfig/conf.d/10-sans-serif.conf` (or `10-mono.conf`, etc.), and replace the current font name with your new font.
6. Match for verification: `fc-match sans-serif` (or `monospace`, `serif`, etc.)
