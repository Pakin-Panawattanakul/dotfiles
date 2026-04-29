config = config
c = c
############################################################
#                                                          #
#                       General config                     #
#                                                          #
############################################################

# Change the argument to True to still load settings configured via autoconfig.yml
config.load_autoconfig(True)

c.tabs.title.format = "{audio}{current_title}"
c.fonts.default_size = "14px"
c.fonts.default_family = "JetBrainsMono Nerd Font"

c.fonts.web.size.default = 18
#c.fonts.web.family.standard = "Noto Serif"
#c.fonts.web.family.serif = "Noto Serif"
#c.fonts.web.family.sans_serif = "Not Sans"

c.fonts.web.family.standard = "JetBrainsMono Nerd Font"
c.fonts.web.family.serif = "Noto Serif"
c.fonts.web.family.sans_serif = "Not Sans"

c.qt.args = [
    '--disable-gpu',
    '--disable-software-rasterizer'
]

c.url.searchengines = {
    # note - if you use duckduckgo, you can make use of its built in bangs, of which there are many! https://duckduckgo.com/bangs
    "DEFAULT": "https://duckduckgo.com/?q={}",
    "aw": "https://wiki.archlinux.org/?search={}",
    "apkg": "https://archlinux.org/packages/?sort=&q={}&maintainer=&flagged=",
    "gh": "https://github.com/search?o=desc&q={}&s=stars",
    "yt": "https://www.youtube.com/results?search_query={}",
    "ud": "https://www.urbandictionary.com/define.php?term={}",
}

c.completion.open_categories = [
    "searchengines",
    "quickmarks",
    "bookmarks",
    "history",
    "filesystem",
]

c.auto_save.session = True  # save tabs on quit/restart

############################################################
#                                                          #
#                        Privacy                           #
#                                                          #
############################################################
# privacy - adjust these settings based on your preference
config.set("completion.cmd_history_max_items", 200)
# config.set("content.private_browsing", True)
config.set("content.webgl", False, "*")
config.set("content.canvas_reading", False)
config.set("content.geolocation", False)
config.set("content.webrtc_ip_handling_policy", "default-public-interface-only")
config.set("content.cookies.accept", "no-3rdparty")
config.set("content.cookies.store", True)
# config.set("content.javascript.enabled", False) # tsh keybind to toggle

config.set("content.javascript.clipboard", "access-paste")

# ads block
c.content.blocking.enabled = True
#c.content.blocking.method = "adblock"  # uncomment this if you install python-adblock
c.content.blocking.adblock.lists = [
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/annoyances-cookies.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/annoyances-others.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/annoyances.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/badlists.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/badware.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/experimental.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters-2020.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters-2021.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters-2022.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters-2023.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters-2024.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters-2025.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters-general.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters-mobile.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/lan-block.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/legacy.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/privacy.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/quick-fixes.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/resource-abuse.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/ubo-link-shorteners.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/ubol-filters.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/unbreak.txt",
]
# "https://github.com/ewpratten/youtube_ad_blocklist/blob/master/blocklist.txt",
############################################################
#                                                          #
#                     Key binding                          #
#                                                          #
############################################################
config.bind("<space>d", "config-cycle colors.webpage.darkmode.enabled true false")
config.bind("<space>n", "tab-next")
config.bind("<space>p", "tab-prev")
config.bind("cm", "clear-messages")

# since i don't use qwerty
config.bind("<Shift-Left>", "back")
config.bind("<Shift-Right>", "forward")
config.bind("<Shift-Down>", "tab-prev")
config.bind("<Shift-Up>", "tab-next")
config.bind('<Ctrl+/>', 'hint links spawn --detach mpv {hint-url}')
############################################################
#                                                          #
#                   Style and Colors                       #
#                                                          #
############################################################
# c.content.user_stylesheets = ["~/.config/qutebrowser/styles/youtube-tweaks.css"]
# c.tabs.indicator.width = 0 # no tab indicators
"""
c.window.transparent = True # apparently not needed
c.colors.tabs.even.bg = "#00000000" # transparent tabs!!
c.colors.tabs.odd.bg = "#00000000"
c.colors.tabs.bar.bg = "#00000000"
"""
c.colors.webpage.preferred_color_scheme = "dark"
c.backend = "webengine"

# dark mode setup
c.colors.webpage.darkmode.enabled = False
c.colors.webpage.darkmode.algorithm = "lightness-cielab"
c.colors.webpage.darkmode.policy.images = "never"
# config.set('colors.webpage.darkmode.enabled', False, 'file://*')

# credits to theova/base16-qutebrowser for the original template

##########
# COLORS #
##########

# base16 colors but with variable names that
# reflect what the color is mainly used for
config.source("themes/nvim-dark.py")
