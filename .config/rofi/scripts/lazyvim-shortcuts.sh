#!/usr/bin/env bash

entries="
NORMAL MODE SHORTCUTS
----------------------------------------
h/j/k/l        Move left/down/up/right
w / b          Jump next/prev word
0 / $          Start/end of line
gg / G         Top / Bottom of file
Ctrl-u / Ctrl-d  Half-page up/down

INSERT MODE
----------------------------------------
i              Insert before cursor
a              Insert after cursor
o              New line below
O              New line above
I              Insert at line start
A              Insert at line end
Esc / Ctrl-[   Exit insert mode

SEARCH & NAVIGATION
----------------------------------------
/              Search forward
?              Search backward
n / N          Next/prev search match
%              Jump matching bracket

EDITING
----------------------------------------
x              Delete character
dd             Delete line
yy             Yank (copy) line
p              Paste after cursor
u              Undo
Ctrl-r         Redo

WINDOWS / TABS
----------------------------------------
:splits
:vsplits
Ctrl-w h/j/k/l  Move between splits
gt / gT        Next/prev tab

LAZYVIM EXTRAS
----------------------------------------
<leader> f f   Find file
<leader> f g   Live grep
<leader> b b   Switch buffer
<leader> u     Toggle UI (like Neo-tree)
<leader> e     File explorer
<leader> l     LSP menu
<leader> g g   Git status
<leader> s s   Save file
<leader> q     Quit

<exit>         Close
"

choice=$(echo "$entries" | rofi -dmenu -i -p "LazyVim Shortcuts")

# No action needed; just display
exit 0

