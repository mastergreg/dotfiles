---------------------------------------------------
--  dark blue theme for awesome wm
--    By Chris S. (cs@nevious.ch)
--    Original theme: zenburn byAdrian C. (anrxc)
-- 
-- Licence:
--      GNU GPLv2
----------------------------------------------------

-- {{{ Main
theme = {}
theme.wallpaper_cmd = {"nitrogen --restore"}
-- }}}

-- {{{ Styles
theme.font      = "monospace 7"

-- {{{ Colors
theme.fg_normal = "#d7d2d0"
theme.fg_focus  = "#3599c9"
theme.fg_urgent = "#e34c10"
theme.bg_normal = "#3b3b3b"
theme.bg_focus  = "#2d2d2d"
theme.bg_urgent = "#3F3F3F"
-- }}}

-- {{{ Borders
theme.border_width  = "1"
theme.border_normal = "#3f3f3f"
theme.border_focus  = "#00a6dc"
theme.border_marked = "#CC9393"
-- }}}

-- {{{ Titlebars
theme.titlebar_bg_focus  = "#254090"
theme.titlebar_bg_normal = "#3F3F3F"
-- }}}

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- [taglist|tasklist]_[bg|fg]_[focus|urgent]
-- titlebar_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
theme.taglist_bg_focus = "#000000"
-- }}}

-- {{{ Widgets
-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
-- theme.fg_widget        = "#AECF96"
-- theme.fg_center_widget = "#88A175"
-- theme.fg_end_widget    = "#FF5656"
-- theme.bg_widget        = "#494B4F"
-- theme.border_widget    = "#3F3F3F"
-- }}}

-- {{{ Mouse finder
theme.mouse_finder_color = "#CC9393"
-- mouse_finder_[timeout|animate_timeout|radius|factor]
-- }}}

-- {{{ Menu
-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_height = "15"
theme.menu_width  = "100"
theme.menu_border_color = "#000000"
-- }}}

-- {{{ Icons
-- {{{ Taglist
theme.taglist_squares_sel   = awful.util.getdir("config") .. "/themes/darkblue/taglist/squarefz.png"
theme.taglist_squares_unsel = awful.util.getdir("config") .. "/themes/darkblue/taglist/squarez.png"
-- theme.taglist_squares_resize = "true"
-- }}}

-- {{{ Misc
theme.awesome_icon           = awful.util.getdir("config") .. "/themes/darkblue/awesome-icon.png"
theme.tasklist_floating_icon = awful.util.getdir("config") .. "/themes/darkblue/tasklist/floating.png"
-- }}}

-- {{{ Layout
theme.layout_tile       = awful.util.getdir("config") .. "/themes/darkblue/layouts/tile.png"
theme.layout_tileleft   = awful.util.getdir("config") .. "/themes/darkblue/layouts/tileleft.png"
theme.layout_tilebottom = awful.util.getdir("config") .. "/themes/darkblue/layouts/tilebottom.png"
theme.layout_tiletop    = awful.util.getdir("config") .. "/themes/darkblue/layouts/tiletop.png"
theme.layout_fairv      = awful.util.getdir("config") .. "/themes/darkblue/layouts/fairv.png"
theme.layout_fairh      = awful.util.getdir("config") .. "/themes/darkblue/layouts/fairh.png"
theme.layout_spiral     = awful.util.getdir("config") .. "/themes/darkblue/layouts/spiral.png"
theme.layout_dwindle    = awful.util.getdir("config") .. "/themes/darkblue/layouts/dwindle.png"
theme.layout_max        = awful.util.getdir("config") .. "/themes/darkblue/layouts/max.png"
theme.layout_fullscreen = awful.util.getdir("config") .. "/themes/darkblue/layouts/fullscreen.png"
theme.layout_magnifier  = awful.util.getdir("config") .. "/themes/darkblue/layouts/magnifier.png"
theme.layout_floating   = awful.util.getdir("config") .. "/themes/darkblue/layouts/floatingw.png"
-- }}}
return theme
