"""
This is a modified version of:
https://gitlab.com/jgkamat/qutemacs/blob/master/qutemacs.py
"""

# All customization done via the UI (:set, :bind and :unbind) is stored in the
# autoconfig.yml file, which is not loaded automatically as soon as a config.py
# exists. If you want
config.load_autoconfig()
config = config  # type: ConfigAPI # noqa: F821 pylint: disable=E0602,C0103
c = c  # type: ConfigContainer # noqa: F821 pylint: disable=E0602,C0103

#####################
# Set misc settings #
#####################

c.completion.open_categories = [
    "searchengines", "quickmarks", "bookmarks", "history"
]
c.input.insert_mode.auto_leave = False
c.input.insert_mode.plugins = False
c.hints.chars = 'asdfjkl'
c.auto_save.session = True

# Forward unbound keys
c.input.forward_unbound_keys = "all"

c.hints.selectors["code"] = [
    # Selects all code tags whose direct parent is not a pre tag
    ":not(pre) > code",
    "pre"
]

###############
# Keybindings #
###############

# Perma bind ctrl-g to escape
c.bindings.key_mappings["<ctrl-g>"] = "<Escape>"

# Default keybindings. If you want to add bindings, modify bindings.commands
# instead.
c.bindings.default['normal'] = {}

# Bindings
c.bindings.commands['normal'] = {
    # Navigation
    '<ctrl-v>': 'scroll-page 0 0.5',
    '<alt-v>': 'scroll-page 0 -0.5',
    '<ctrl-,>': 'scroll-to-perc 0',
    '<ctrl-.>': 'scroll-to-perc',

    # Commands
    '<alt-x>': 'set-cmd-text :',
    '<ctrl-j>': 'set-cmd-text -s :buffer',
    '<ctrl-w>': 'tab-close',
    '<ctrl-x><ctrl-c>': 'quit',

    # searching
    '<ctrl-s>': 'set-cmd-text /',
    '<ctrl-r>': 'set-cmd-text ?',

    # hinting
    '<ctrl-;>': 'hint links',
    '<ctrl-#>': 'hint code userscript code_select.py',
    '<alt-\'>': 'hint inputs',
    '<ctrl-\'>': 'hint all tab',

    # history
    '<ctrl-]>': 'forward',
    '<ctrl-[>': 'back',

    # tabs
    '<ctrl-tab>': 'tab-focus last',
    '<ctrl-shift-tab>': 'tab-next',
    '<alt-o>': 'tab-focus last',
    '<alt-;>': 'tab-next',
    '<alt-j>': 'tab-prev',
    '<ctrl-u>': 'undo',
    # Copied from defaults - but initial 'p' changed to 'o'
    '<ctrl-o><ctrl-p>': 'open -t -- {clipboard}',   # Open new tab from clipboard url
    '<ctrl-g><ctrl-f>': 'view-source',
    '<ctrl-c><ctrl-t>': 'tab-clone',

    # open links
    '<ctrl-l>': 'set-cmd-text -s :open',
    '<alt-l>': 'set-cmd-text -s :open -t',
    '<ctrl-c><ctrl-w>': 'yank',                    # Defaults to current url
    '<alt-w>': 'yank',                             # Just convenient

    # For convenience
    'n': 'fake-key <Down>',
    'p': 'fake-key <Up>',
    'f': 'fake-key <Right>',
    'b': 'fake-key <Left>',

    '<ctrl-n>': 'fake-key <Down>',
    '<ctrl-p>': 'fake-key <Up>',
    '<ctrl-f>': 'fake-key <Right>',
    '<ctrl-b>': 'fake-key <Left>',

    # Numbers
    # https://github.com/qutebrowser/qutebrowser/issues/4213
    '1': 'fake-key 1',
    '2': 'fake-key 2',
    '3': 'fake-key 3',
    '4': 'fake-key 4',
    '5': 'fake-key 5',
    '6': 'fake-key 6',
    '7': 'fake-key 7',
    '8': 'fake-key 8',
    '9': 'fake-key 9',
    '0': 'fake-key 0',

    '<ctrl-c><ctrl-,>': 'spawn --userscript qute-pass',
    '<ctrl-c><ctrl-f>': 'spawn --userscript firefox-open',
    '<ctrl-c><ctrl-r>': 'reload',

    '<ctrl-h>': 'set-cmd-text -s :help',
}

c.bindings.commands['insert'] = {
    '<Ctrl-f>': 'fake-key <Right>',
    '<Ctrl-b>': 'fake-key <Left>',
    '<Ctrl-a>': 'fake-key <Home>',
    '<Ctrl-e>': 'fake-key <End>',
    '<Ctrl-n>': 'fake-key <Down>',
    '<Ctrl-p>': 'fake-key <Up>',
    '<Alt-v>': 'fake-key <PgUp>',
    '<Ctrl-v>': 'fake-key <PgDown>',
    '<Alt-f>': 'fake-key <Ctrl-Right>',
    '<Alt-b>': 'fake-key <Ctrl-Left>',
    '<Ctrl-d>': 'fake-key <Delete>',
    '<Alt-d>': 'fake-key <Ctrl-Delete>',
    '<Alt-Backspace>': 'fake-key <Ctrl-Backspace>',
    '<Ctrl-y>': 'insert-text {primary}',
}

c.bindings.commands['command'] = {
    '<ctrl-s>': 'search-next',
    '<ctrl-r>': 'search-prev',

    '<ctrl-p>': 'completion-item-focus prev',
    '<ctrl-n>': 'completion-item-focus next',

    '<alt-p>': 'command-history-prev',
    '<alt-n>': 'command-history-next',
}

# Do bookmarks
"""
with open(expanduser("~") + "/.config/qutebrowser/bookmarks/urls") as f:
    print(f.read())
"""
