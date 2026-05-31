QueryVS Neovim Keymap Guide
===========================

Leader key: Space

Leader key is not a modifier. Press Space, release it, then press the rest of
the shortcut. Example: Space ff means Space, then f, then f.


General
-------
Esc                 Clear search highlight
Space w             Save file
Space q             Quit window
Space x             Close current buffer
Space sv            Reload init.vim


Windows and Splits
------------------
Ctrl h              Move to left window
Ctrl j              Move to lower window
Ctrl k              Move to upper window
Ctrl l              Move to right window

Alt Shift h         Decrease window width
Alt Shift l         Increase window width
Alt Shift j         Decrease window height
Alt Shift k         Increase window height

Space rh            Decrease window width
Space rl            Increase window width
Space rj            Decrease window height
Space rk            Increase window height
Space r=            Equalize all split sizes


Buffers
-------
Buffers are still available, but the main workflow uses real Vim tabs because
tabs preserve their own split layout. Use buffer shortcuts only when you want to
change the file inside the current window.

Space bn            Next buffer
Space bp            Previous buffer


Tabs
----
Tab                 Next tab
Shift Tab           Previous tab
Alt j               Next tab
Alt k               Previous tab
Alt Down            Next tab
Alt Up              Previous tab
Alt h               Previous tab
Alt l               Next tab
Alt Left            Previous tab
Alt Right           Next tab
Ctrl Left           Previous tab
Ctrl Right          Next tab
Space tp            Previous tab
Space tl            Next tab
Space tn            New tab
Space tc            Close tab


Files and Search
----------------
Ctrl n              Toggle Neo-tree
Space e             Toggle Neo-tree and reveal current file
Space ff            Find files
Space fg            Live grep in project
Space fb            Find open buffers
Space fh            Search help tags
Space fr            Resume last picker
Space fm            Open mini file explorer


Neo-tree
--------
Enter               Expand/collapse directory, or open file in a new tab
o                   Same as Enter
s                   Open file in vertical split inside current tab
S                   Open file in horizontal split inside current tab
v                   Open file in vertical split inside current tab
t                   Open file in new tab
T                   Open terminal at selected file/directory location


Terminal
--------
Space tt            Open/focus persistent bottom terminal panel
Ctrl t              Open/focus persistent bottom terminal panel
Space tv            Open/focus persistent vertical terminal panel
Space tf            Open new bottom terminal at last focused file directory
Space tF            Open new vertical terminal at last focused file directory

Esc                 Leave terminal mode and return to Vim commands
Esc Esc             Same as Esc
Ctrl h              Leave terminal mode and move to left window
Ctrl j              Leave terminal mode and move to lower window
Ctrl k              Leave terminal mode and move to upper window
Ctrl l              Leave terminal mode and move to right window
Alt j               Leave terminal mode and go to next tab
Alt k               Leave terminal mode and go to previous tab
Alt h               Leave terminal mode and go to previous tab
Alt l               Leave terminal mode and go to next tab


Coding with CoC
---------------
Tab                 Next completion item in insert mode
Shift Tab           Previous completion item in insert mode
Enter               Confirm selected completion item
gd                  Go to definition
gy                  Go to type definition
gi                  Go to implementation
gr                  Go to references
K                   Show hover documentation
[g                  Previous diagnostic
]g                  Next diagnostic
Space rn            Rename symbol
Space cf            Format selected code/current region
Space ca            Code action
Space cd            Show diagnostics list
Space cl            Open CoC list
Space co            Open symbol outline
Space cs            Search workspace symbols


Git and Code Review
-------------------
Space gs            Git status
Space gb            Git blame
Space gD            Git diff split
Space gl            Git log
Space gp            Git push
Space gP            Git pull

[q                  Previous quickfix item
]q                  Next quickfix item
[l                  Previous location-list item
]l                  Next location-list item


Lint and Fix
------------
Space aa            Toggle ALE
Space ad            Show ALE diagnostic detail
Space af            Run ALE fix
Space al            Open location list


Markdown
--------
Space md            Toggle render-markdown
Space mp            Open Glow markdown preview


Editing Helpers
---------------
Space a             EasyAlign
Space td            Trim trailing whitespace
