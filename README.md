# [Mike Mob](https://mikemob.com)'s Dotfiles
🇮 ❤️ 🐧



## Software
| Program | Name | Description |
|---|---|---|
| Desktop Environment | [KDE Plasma](https://kde.org/plasma-desktop) | Desktop environment by [KDE](https://kde.org).
| Web Browser | [Firefox](https://www.mozilla.org/en-US/firefox) | Web browser by [Mozilla](https://www.mozilla.org). |
| E-mail Client | [Thunderbird](https://www.thunderbird.net/en-US) | E-mail client by [Mozilla](https://www.mozilla.org). |
| Terminal Multiplexer | [Tmux](https://github.com/tmux/tmux) | [GNU Screen](https://www.gnu.org/software/screen) alternative. |
| Text Editor | [Neovim](https://neovim.io) | Modal editing. Forked from [vim](https://www.vim.org/). |

Unless otherwise specified, I tend to use [KDE Applications](https://kde.org/applications).


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
