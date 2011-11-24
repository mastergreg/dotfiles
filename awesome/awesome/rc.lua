-- Standard awesome library
require("awful")
require("awful.autofocus")
require("awful.rules")
-- Theme handling library
require("beautiful")
-- Notification library
require("naughty")

require("scratch")
require("vicious")
-- {{{ Variable definitions
-- Themes define colours, icons, and wallpapers
--beautiful.init("/home/wired/.config/awesome/void/theme.lua")
--beautiful.init("/home/wired/.config/awesome/void_v2/theme.lua")
beautiful.init(awful.util.getdir('config').."/themes/foo-too/theme.lua")

-- This is used later as the default terminal and editor to run.
terminal = "urxvt"
editor = os.getenv("EDITOR") or "vim"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
layouts =
{
    awful.layout.suit.tile,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.max,
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier,
    awful.layout.suit.floating
}
-- }}}

-- {{{ Tags
-- Define a tag table which hold all screen tags.
tags = {}
tagnames = {}
taglayouts = {}
tagcount = { 9, 9 }
tagnames[1] = { "sh","www","dev","dev","sh","chat","mail","music","movies" }
taglayouts[1] = { layouts[6], layouts[1], layouts[1],layouts[1], layouts[1], layouts[1], layouts[1], layouts[1],  layouts[7] }

tagnames[2] = { "sh","www","dev","dev","sh","chat","mail","music","movies"}
taglayouts[2] = { layouts[6], layouts[1], layouts[1],layouts[1], layouts[1], layouts[1], layouts[1], layouts[1],  layouts[7] }


for s = 1, screen.count() do
    -- Each screen has its own tag table.
    tags[s] = awful.tag(tagnames[s], s)
    for tagnumber = 1, tagcount[s] do
	awful.layout.set(taglayouts[s][tagnumber], tags[s][tagnumber])
    end
end
-- }}}

-- {{{ Menu
-- Create a laucher widget and a main menu
myawesomemenu = {
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awful.util.getdir("config") .. "/rc.lua" },
   { "restart", awesome.restart },
   { "quit", awesome.quit }
}

mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
                                    { "open terminal", terminal }
                                  }
                        })

mylauncher = awful.widget.launcher({ image = image(beautiful.awesome_icon),
                                     menu = mymainmenu })
-- }}}

-- {{{ Wibox
-- Create a textclock widget
mytextclock = awful.widget.textclock({ align = "right" })

-- Create a systray
mysystray = widget({ type = "systray" })
-- CPU usage widget


cpu1 = widget({ type = "textbox" })
vicious.register(cpu1, vicious.widgets.cpufreq, function(widget,args) return "<span color = '#ff0000'>"..string.sub(args[2],1,3).."</span>G" end,1,"cpu0")
cpu2 = widget ({ type = "textbox" })
vicious.register(cpu2, vicious.widgets.cpufreq, function(widget,args) return "<span color = '#ff0000'>"..string.sub(args[2],1,3).."</span>G" end,1,"cpu1")
vicious.cache(vicious.widgets.cpufreq)


cpuwidget = awful.widget.progressbar()
cpuwidget:set_width(50)
cpuwidget:set_height(10)
cpuwidget:set_vertical(false)
cpuwidget:set_border_color("#AAAAAA")
cpuwidget:set_background_color("#494B4F")
cpuwidget:set_color("#FF5656")
cpuwidget:set_gradient_colors({ '#00FF00', '#FFFF00', '#FF0000' })

vicious.register(cpuwidget, vicious.widgets.cpu,"$2")

cpu2widget = awful.widget.progressbar()
cpu2widget:set_width(50)
cpu2widget:set_height(10)
cpu2widget:set_vertical(false)
cpu2widget:set_border_color("#AAAAAA")
cpu2widget:set_background_color("#494B4F")
cpu2widget:set_color("#FF5656")
cpu2widget:set_gradient_colors({ '#00FF00', '#FFFF00', '#FF0000' })
--
vicious.register(cpu2widget, vicious.widgets.cpu,"$3")
vicious.cache(vicious.widgets.cpu)


eth0widget = widget({ type = "textbox" })
eth0widget.width=130
vicious.register(eth0widget,vicious.widgets.net,function (widget,args) return "eth0: <span color = '#00ff00'>"..args["{eth0 down_kb}"].."</span> / <span color = '#00ff00'>"..args["{eth0 up_kb}"].."</span> KB" end)
wlan0widget = widget({ type = "textbox" })
wlan0widget.width=130
vicious.register(wlan0widget,vicious.widgets.net,function (widget,args) return "wlan0: <span color = '#00ff00'>"..args["{wlan0 down_kb}"].."</span> / <span color = '#00ff00'>"..args["{wlan0 up_kb}"].."</span> KB" end)
vicious.cache(vicious.widgets.net)
vicious.cache(vicious.widgets.net)


ffoxlauncher = awful.widget.launcher( {image = "/home/master/.config/awesome/icon/firefox.png",command = "firefox"})
maillauncher = awful.widget.launcher( {image = "/home/master/.config/awesome/icon/email.png",command = "thunderbird"})
skypelauncher = awful.widget.launcher( {image = "/home/master/.config/awesome/icon/skype.png",command = "skype"})
--



-- Initialize widget
mpdwidget = widget({ type = "textbox" })
-- Register widget
vicious.register(mpdwidget, vicious.widgets.mpd,
    function (widget, args)
            if args["{state}"] == "Stop" then 
                        return " - "
                      else 
                        return args["{Artist}"]..' - '.. args["{Title}"]
                      end
                    end, 10)
spacer = widget({type = "textbox"}) 
separator = widget({type = "textbox"}) 
spacer.text = " " 
separator.text = "|" 


-- RAM usage widget
 memwidget = awful.widget.progressbar()
 memwidget:set_width(45)
 memwidget:set_height(10)
 memwidget:set_vertical(false)
 memwidget:set_border_color("#AAAAAA")
 memwidget:set_background_color('#494B4F')
 memwidget:set_color('#AECF96')
 memwidget:set_gradient_colors({ '#00FF00', '#FFFF00', '#FF0000' })

 -- RAM usage tooltip
 memwidget_t = awful.tooltip({ objects = { memwidget.widget },})

 vicious.cache(vicious.widgets.mem)
 vicious.register(memwidget, vicious.widgets.mem,
                 function (widget, args) memwidget_t:set_text(" RAM: " .. args[2] .. "MB / " .. args[3] .. "MB ") return args[1] end, 13)
                                                                           --update every 13 seconds


-- Volume widget

volumecfg = {}
volumecfg.cardid  = 0
volumecfg.channel = "Master"
volumecfg.widget = widget({ type = "textbox", name = "volumecfg.widget", align = "right" })

volumecfg_t = awful.tooltip({ objects = { volumecfg.widget },})
volumecfg_t:set_text("Volume")

-- command must start with a space!
volumecfg.mixercommand = function (command)
       local fd = io.popen("amixer -c " .. volumecfg.cardid .. command)
       local status = fd:read("*all")
                     fd:close()

       local volume = string.match(status, "(%d?%d?%d)%%")
       volume = string.format("% 3d", volume)
       status = string.match(status, "%[(o[^%]]*)%]")
       if string.find(status, "on", 1, true) then
       volume = volume .. "%"
       else
       volume = volume .. "M"
       end
       volumecfg.widget.text = volume
       end
       volumecfg.update = function ()
       volumecfg.mixercommand(" sget " .. volumecfg.channel)
       end
       volumecfg.up = function ()
       volumecfg.mixercommand(" sset " .. volumecfg.channel .. " 1%+")
       end
       volumecfg.down = function ()
       volumecfg.mixercommand(" sset " .. volumecfg.channel .. " 1%-")
       end
       volumecfg.toggle = function ()
       volumecfg.mixercommand(" sset " .. volumecfg.channel .. " toggle")
       end
       volumecfg.widget:buttons({
       button({ }, 4, function () volumecfg.up() end),
       button({ }, 5, function () volumecfg.down() end),
       button({ }, 1, function () volumecfg.toggle() end)
       })
       volumecfg.update()

-- Weather widget
weatherwidget = widget({ type = "textbox" })
weather_t = awful.tooltip({ objects = { weatherwidget },})

vicious.register(weatherwidget, vicious.widgets.weather,
                function (widget, args)
                    weather_t:set_text("City: " .. args["{city}"] .."\nWind: " .. args["{windkmh}"] .. "km/h " .. args["{wind}"] .. "\nSky: " .. args["{sky}"] .. "\nHumidity: " .. args["{humid}"] .. "%")
                    return args["{tempc}"] .. "C"
                end, 1800, "LGAV")
                --'1800': check every 30 minutes.




-- Create a wibox for each screen and add it
mywibox = {}
myprocbox = {}
mytaskbox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag),
                    awful.button({ }, 4, awful.tag.viewnext),
                    awful.button({ }, 5, awful.tag.viewprev)
                    )
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if not c:isvisible() then
                                                  awful.tag.viewonly(c:tags()[1])
                                              end
                                              client.focus = c
                                              c:raise()
                                          end),
                     awful.button({ }, 3, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({ width=250 })
                                              end
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                              if client.focus then client.focus:raise() end
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                              if client.focus then client.focus:raise() end
                                          end))


for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt({ layout = awful.widget.layout.horizontal.leftright })
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.label.all, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(function(c)
                                              return awful.widget.tasklist.label.currenttags(c, s)
                                          end, mytasklist.buttons)

    -- Create the wibox
    mywibox[s] = awful.wibox({ position = "top", screen = s })
    -- Add widgets to the wibox - order matters
    mywibox[s].widgets = {
      { 
          {
            mylayoutbox[s],
            mytextclock,
            s == 1 and mysystray or nil,
            spacer or nil,
            spacer or nil,
            volumecfg.widget or nil,
            separator or nil,
            spacer or nil,
            weatherwidget or nil,
            spacer or nil,
            separator or nil,
            spacer or nil,
            memwidget.widget or nil,
            spacer or nil,
            cpu1temp or nil,
            spacer or nil,
            cpu2 or nil,
            spacer or nil,
            cpu2widget.widget or nil,
            spacer or nil,
            cpu1 or nil,
            spacer or nil,
            cpuwidget.widget or nil,
            spacer or nil,
            eth0widget or nil,
            spacer or nil,
            wlan0widget or nil,
            spacer or nil,
            separator or nil,
            spacer or nil,
            mpdwidget or nil,
            spacer or nil,
            layout = awful.widget.layout.horizontal.rightleft
          },
          --{
          --  cpu2widget.widget,
          --  cpuwidget.widget,
          --  layout = awful.widget.layout.vertical.flex
          --},
          --layout = awful.widget.layout.horizontal.leftright
      },
--          {
--            mylauncher,
--            mytaglist[s],
--            mypromptbox[s],
--		        mytasklist[s],
--            layout = awful.widget.layout.horizontal.leftright
--          },
	    layout = awful.widget.layout.vertical.flex,
	    height = mywibox[s].height
    }

    mytaskbox[s] = awful.wibox({ position = "bottom", screen = s })
    mytaskbox[s].widgets = {
            mylauncher,
            mytaglist[s],
            mypromptbox[s],
		        mytasklist[s],
            layout = awful.widget.layout.horizontal.leftright
    }
end

--myprocbox[1] = awful.wibox({ position = "right", border_width = 0, fg = beautiful.fg_normal, bg = beautiful.bg_normal, screen = 1 })
--myprocbox[1].widgets = {
--	Dtop,
----	Separator1,
----	Separator1,
----	Separator3,
----	Separator3,
--	layout = awful.widget.layout.horizontal.leftright
--}


-- }}}

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then 
	    	client.focus:raise() 
	        warp_mouse(client.focus)
	    end
        end),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then
	    	client.focus:raise() 
	        warp_mouse(client.focus)
	    end
        end),
    -- awful.key({ modkey,           }, "w", function () mymainmenu:show(true)        end),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
    awful.key({ modkey,       	  }, "o", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey,  "Shift"  }, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
    awful.key({ modkey,           }, "grave", function () awful.util.spawn(terminal) end),
    awful.key({                   }, "grave", function () scratch.drop(terminal, "center", 1, 0.9,0.6) end),
    awful.key({ modkey,           }, "p", function () awful.util.spawn("gmrun") end),
    awful.key({ modkey,           }, "1", function () awful.util.spawn("uzbl-browser") end),



    awful.key({ modkey, "Control" }, "r", awesome.restart),
    awful.key({ modkey, "Control", "Shift" }, "q", awesome.quit),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
    awful.key({ modkey, "Mod1"    }, "h",     function () awful.tag.incncol( 1)         end),
    awful.key({ modkey, "Mod1"    }, "l",     function () awful.tag.incncol(-1)         end),
    awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),

    awful.key({ modkey,           }, ".", function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey, 	  }, ",", function () awful.layout.inc(layouts, -1) end),
    awful.key({ modkey,           }, "v", function () awful.layout.set(layouts[2]) end),
    awful.key({ modkey, 	  }, "n", function () awful.layout.set(layouts[7]) end),
    awful.key({ modkey, 	  }, "b", function () awful.layout.set(layouts[6]) end),

    awful.key({ modkey,           }, "y", function () awful.client.focus.bydirection("left") end),
    awful.key({ modkey,           }, "u", function () awful.client.focus.bydirection("down") end),
    awful.key({ modkey,           }, "i", function () awful.client.focus.bydirection("up") end),
    awful.key({ modkey,           }, "o", function () awful.client.focus.bydirection("right") end),

    -- Prompt
    awful.key({ modkey },            "r",     function () mypromptbox[mouse.screen]:run() end),

    awful.key({ modkey }, "b",
              function ()
                  awful.prompt.run({ prompt = "Run Lua code: " },
                  mypromptbox[mouse.screen].widget,
                  awful.util.eval, nil,
                  awful.util.getdir("cache") .. "/history_eval")
              end),

    -- Apps
    awful.key({ modkey,  }, "f", function () awful.util.spawn("firefox") end),
    awful.key({ modkey,  }, "m", function () awful.util.spawn("thunderbird") end),
    awful.key({ modkey,  }, "s", function () awful.util.spawn("skype") end),
    awful.key({ modkey,  }, "t", function () awful.util.spawn("pcmanfm") end),

    -- System stuff
    -- Volume
    awful.key({ }, "XF86AudioRaiseVolume", function () volumecfg.up() end),
    awful.key({ }, "XF86AudioLowerVolume", function () volumecfg.down() end),
    awful.key({ }, "XF86AudioMute", function () volumecfg.toggle() end),
    awful.key({ }, "XF86AudioNext", function () awful.util.spawn("mpc next") end),
    awful.key({ }, "XF86AudioPrev", function () awful.util.spawn("mpc prev") end),
    awful.key({ }, "XF86AudioPlay", function () awful.util.spawn("mpc toggle") end),
    awful.key({ }, "XF86AudioStop", function () awful.util.spawn("mpc stop") end),
    awful.key({ }, "Print", function () awful.util.spawn("scrot -e 'mv $f ~/screenshots/ 2>/dev/null'") end)

)

clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "z",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey,           }, "m",      function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey, "Shift"   }, "r",      function (c) c:redraw()                       end),
    awful.key({ modkey,           }, "v",      function (c) c.minimized = not c.minimized    end),
    awful.key({ modkey,           }, "x",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end)
)

-- Compute the maximum number of digit we need, limited to 9
keynumber = 0
for s = 1, screen.count() do
   keynumber = math.min(9, math.max(#tags[s], keynumber));
end

wskeys = { "1","2","3","4","5","6","7","8","9","0" }

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, keynumber do
    globalkeys = awful.util.table.join(globalkeys,
        awful.key({ modkey }, wskeys[i],
                  function ()
                        local screen = mouse.screen
                        if tags[screen][i] then
                            awful.tag.viewonly(tags[screen][i])
                        end
                  end),
        awful.key({ modkey, "Mod1" }, wskeys[i],
                  function ()
                      local screen = mouse.screen
                      if tags[screen][i] then
                          awful.tag.viewtoggle(tags[screen][i])
                      end
                  end),
        awful.key({ modkey, "Shift" }, wskeys[i],
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.movetotag(tags[client.focus.screen][i])
                      end
                  end),
        awful.key({ modkey, "Control", "Shift" }, wskeys[i],
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.toggletag(tags[client.focus.screen][i])
                      end
                  end))
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = true,
                     keys = clientkeys,
                     buttons = clientbuttons } },
    { rule = { class = "MPlayer" },
      properties = { floating = true } },
    { rule = { class = "pinentry" },
      properties = { floating = true } },
    { rule = { instance = "gimp" },
      properties = { floating = true, tag = tags[1][8]} },
    { rule = { instance = "gimp-2.6" },
      properties = { floating = true, tag = tags[1][8]} },
    { rule = { class = "Firefox" },
      properties = { floating = false, tag = tags[1][2] } },
    { rule = { class = "Thunderbird" },
      properties = { floating = false, tag = tags[1][7] } },
    { rule = { class = "Skype" },
      properties = { tag = tags[1][6] } },
    { rule = { class = "Pidgin" },
      properties = { tag = tags[1][6] } }
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.

client.add_signal("manage", function (c, startup)
    -- Add a titlebar
    -- awful.titlebar.add(c, { modkey = modkey })

    -- Enable sloppy focus
    c:add_signal("mouse::enter", function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
            client.focus = c
        end
    end)

    if not startup then
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        -- awful.client.setslave(c)

        -- Put windows in a smart way, only if they does not set an initial position.
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
    end

--    if use_titlebar_floatapp then
	--    if c.fullscreen then
	--	awful.titlebar.remove(c)
	--    elseif awful.client.floating.get(c) then
	--    else
	--	awful.titlebar.add(c, { modkey = modkey })
	--    end
--    end
end)

client.add_signal("focus", function(c) 
	c.border_color = beautiful.border_focus 
	-- warp_mouse(c)
end)
client.add_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

function warp_mouse(c)
	local o = awful.mouse.client_under_pointer()
	if not o or o ~= c then
		local g = c:geometry()
		mouse.coords({ x = g.x + 5, y = g.y + 5 }, true)
	end
end

-- for s = 1, screen.count() do
-- 	screen[s]:add_signal("arrange", function ()
-- 		if client.focus and client.focus.screen == s then
--			warp_mouse(client.focus)
-- 		end
-- 	end)
-- end

-- }}}
