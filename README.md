## showcharcode
Minor mode for emacs designed to show character code under cursor.

In typical case you need to call what-cursor-potision function by pressing C-x = at each character.

After enabling this mode character info is displayed at echo area for character under point.

## usage
Install showcharcode.el into preferred dir.

Add this lines to your .emacs

    (add-to-list 'load-path "/path/to/preferred-dir")
    (require 'showcharcode)

Mode is disabled by default, because its needed only in special case.
To toggle this mode:

    M-x showcharcode-mode
