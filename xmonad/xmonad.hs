--
-- xmonad example config file.
--
-- A template showing all available configuration hooks,
	-- and how to override the defaults in your own xmonad.hs conf file.
	--
	-- Normally, you'd only override those defaults you care about.
	--
import List ( isPrefixOf )
import XMonad
import System.Exit

import System.IO
import System.Time
import System.Locale
import System.Environment

	--import System.IO.UTF8
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.UrgencyHook
import XMonad.Hooks.FadeInactive as FI
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Layout.Grid
import XMonad.Layout.Named
import XMonad.Layout.NoBorders
import XMonad.Layout.PerWorkspace
import XMonad.Layout.DecorationMadness
import XMonad.Layout.TwoPane
import XMonad.Layout.Combo
import XMonad.Layout.ComboP
import XMonad.Layout.Tabbed
import XMonad.Layout.IM
import XMonad.Layout.Reflect
import Data.Ratio ((%))
import XMonad.Util.Scratchpad 
import XMonad.Hooks.SetWMName
--import XMonad.Hooks.EwmhDesktops
	--import XMonad.Layout.Reflect
	--import XMonad.Layout.LayoutHints

import qualified XMonad.StackSet as W
import qualified Data.Map        as M

	-- The preferred terminal program, which is used in a binding below and by
	-- certain contrib modules.
	--
myTerminal      = "urxvt"
--myTerminal      = "terminator"
	-- Width of the window border in pixels.
	--
myBorderWidth   = 1

	-- modMask lets you specify which modkey you want to use. The default
	-- is mod1Mask ("left alt").  You may also consider using mod3Mask
	-- ("right alt"), which does not conflict with emacs keybindings. The
	-- "windows key" is usually mod4Mask.
	--
--myModMask       = mod1Mask
myModMask       = mod4Mask

	-- The mask for the numlock key. Numlock status is "masked" from the
	-- current modifier status, so the keybindings will work with numlock on or
	-- off. You may need to change this on some systems.
	--
	-- You can find the numlock modifier by running "xmodmap" and looking for a
	-- modifier with Num_Lock bound to it:
	--
	-- > $ xmodmap | grep Num
-- > mod2        Num_Lock (0x4d)
	--
	-- Set numlockMask = 0 if you don't have a numlock key, or want to treat
	-- numlock status separately.
	--
myNumlockMask   = mod2Mask

	-- The default number of workspaces (virtual screens) and their names.
	-- By default we use numeric strings, but any string may be used as a
	-- workspace name. The number of workspaces is determined by the length
	-- of this list.
	--
	-- A tagging example:
	--
	-- > workspaces = ["web", "irc", "code" ] ++ map show [4..9]
	--
myWorkspaces = ["1","2","3","4","5","6","7","8","9","0"]
 
	--    where miscs = map (("misc" ++) . show) . (flip take) [1..]
	--isFullscreen = (== "fullscreen")

	-- Border colors for unfocused and focused windows, respectively.
	--
myNormalBorderColor  = "#1c1c1c"
myFocusedBorderColor = "#0077ff"

	-- Default offset of drawable screen boundaries from each physical
	-- screen. Anything non-zero here will leave a gap of that many pixels
	-- on the given edge, on the that screen. A useful gap at top of screen
-- for a menu bar (e.g. 15)
	--
	-- An example, to set a top gap on monitor 1, and a gap on the bottom of
	-- monitor 2, you'd use a list of geometries like so:
	--
	-- > defaultGaps = [(18,0,0,0),(0,18,0,0)] -- 2 gaps on 2 monitors
	--
	-- Fields are: top, bottom, left, right.
	--
myDefaultGaps   = [(0,0,0,0)]

	------------------------------------------------------------------------
	-- Key bindings. Add, modify or remove key bindings here.
myWorkspaceSwichKeys=[xK_1 .. xK_9]++[xK_0]++[xK_minus]++[xK_equal]

		--
myKeys conf@(XConfig {XMonad.modMask = modMask}) = M.fromList $

	-- launch a terminal
	[ ((modMask .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)

	-- launch dmenu
--	, ((modMask,               xK_p     ), spawn "exe=`dmenu_path | dmenu` && eval \"exec $exe\"")

	-- launch gmrun
	, ((modMask , xK_p     ), spawn "gmrun")

	-- close focused window 
	, ((modMask .|. shiftMask, xK_c     ), kill)

	-- Rotate through the available layout algorithms
	, ((modMask,               xK_space ), sendMessage NextLayout)

	--  Reset the layouts on the current workspace to default
	, ((modMask .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)

	-- Resize viewed windows to the correct size
	, ((modMask,               xK_n     ), refresh)

	-- Move focus to the next window
	, ((modMask,               xK_Tab   ), windows W.focusDown)

	-- Move focus to the next window
	, ((modMask,               xK_j     ), windows W.focusDown)

	-- Move focus to the previous window
	, ((modMask,               xK_k     ), windows W.focusUp  )

	-- Move focus to the master window
	, ((modMask,               xK_m     ), windows W.focusMaster  )

	-- Swap the focused window and the master window
	, ((modMask,               xK_Return), windows W.swapMaster)

	-- Swap the focused window with the next window
	, ((modMask .|. shiftMask, xK_j     ), windows W.swapDown  )

	-- Swap the focused window with the previous window
	, ((modMask .|. shiftMask, xK_k     ), windows W.swapUp    )

	-- Shrink the master area
	, ((modMask,               xK_h     ), sendMessage Shrink)

	-- Expand the master area
	, ((modMask,               xK_l     ), sendMessage Expand)

	-- Push window back into tiling
	, ((modMask.|. shiftMask,  xK_t     ), withFocused $ windows . W.sink)

	-- Increment the number of windows in the master area
	, ((modMask              , xK_comma ), sendMessage (IncMasterN 1))

	-- Deincrement the number of windows in the master area
	, ((modMask              , xK_period), sendMessage (IncMasterN (-1)))

	-- toggle the status bar gap
	--, ((modMask              , xK_b     ),
			--     modifyGap (\i n -> let x = (XMonad.defaultGaps conf ++ repeat (0,0,0,0)) !! i
				--                         in if n == x then (0,0,0,0) else x))

	-- Quit xmonad
	, ((modMask .|. shiftMask, xK_q     ), io (exitWith ExitSuccess))

	-- Restart xmonad
	, ((modMask              , xK_q     ), restart "xmonad" True)
	]
	++

	--
	-- mod-[1..9], Switch to workspace N
	-- mod-shift-[1..9], Move client to workspace N
	--

	[((m .|. modMask, k), windows $ f i)
	| (i, k) <- zip (XMonad.workspaces conf) myWorkspaceSwichKeys
	, (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
	++

	--
	-- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
	-- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
	--
	[((m .|. modMask, key), screenWorkspace sc >>= flip whenJust (windows . f))
	| (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
	, (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]
	++

	--
	-- my Additional Keybindings
	--
	[((mod4Mask             , xK_f     ), spawn "firefox")
	, ((mod4Mask             , xK_x     ), spawn myTerminal)
	, ((mod4Mask             , xK_s     ), spawn "pidgin")
	, ((mod4Mask             , xK_a     ), spawn "urxvt -e ncmpcpp")
	, ((mod4Mask             , xK_m     ), spawn "thunderbird")
	, ((mod4Mask             , xK_d     ), spawn "eclipse")
	, ((mod4Mask             , xK_g     ), spawn "gvim")
	, ((mod4Mask             , xK_F10     ), spawn "set_screen")
	, ((mod4Mask.|. shiftMask, xK_F10     ), spawn "set_screen_off")
	, ((mod4Mask             ,xK_grave), spawn myTerminal)
	, ((0                    ,xK_grave), scratchpadSpawnActionTerminal "urxvt -pe tabbed -T term")
  , ((mod4Mask             ,xK_t), spawn "pcmanfm")
	, ((0                    ,xK_Print), spawn  "scrot -e 'mv $f ~/Pictures/Screenshots'")
	, ((mod4Mask             ,xK_Print), spawn  "scrot -e 'mv $f ~/Dropbox/Screenshots'")
	, ((0                    ,0x1008ff11),spawn "volbar -d 1")
	, ((0                    ,0x1008ff13),spawn "volbar -i 1")
	, ((0                    ,0x1008ff12),spawn "volbar -t")
  , ((0                    ,0x1008ff14),spawn "mpd_extra_buttons toggle")
  , ((0                    ,0x1008ff16),spawn "mpd_extra_buttons prev")
  , ((0                    ,0x1008ff17),spawn "mpd_extra_buttons next")
	]	


	------------------------------------------------------------------------
	-- Mouse bindings: default actions bound to mouse events
	--
myMouseBindings (XConfig {XMonad.modMask = modMask}) = M.fromList $

	-- mod-button1, Set the window to floating mode and move by dragging
	[ ((modMask, button1), (\w -> focus w >> mouseMoveWindow w))

	-- mod-button2, Raise the window to the top of the stack
	, ((modMask, button2), (\w -> focus w >> windows W.swapMaster))

	-- mod-button3, Set the window to floating mode and resize by dragging
	, ((modMask, button3), (\w -> focus w >> mouseResizeWindow w))

-- you may also bind events to the mouse scroll wheel (button4 and button5)
	]

	------------------------------------------------------------------------
	-- Layouts:

	-- You can specify and transform your layouts by modifying these values.
	-- If you change layout bindings be sure to use 'mod-shift-space' after
	-- restarting (with 'mod-q') to reset your layout state to the new
	-- defaults, as xmonad preserves your old layout settings by default.
	--
	-- The available layouts.  Note that each layout is separated by |||,
	-- which denotes layout choice.
	--

	-- default tiling algorithm partitions the screen into two panes
basicLayout = Tall nmaster delta ratio where
	-- The default number of windows in the master pane
nmaster = 1
	-- Percent of screen to increment by when resizing panes
delta   = 3/100
	-- Default proportion of screen occupied by master pane
ratio   = 2/4
tallLayout = named "tall" $ avoidStruts $ basicLayout
wideLayout = named "wide" $ avoidStruts $ Mirror basicLayout
singleLayout = named "single" $ avoidStruts $ noBorders Full
circleLayout = named "circle" $  circleSimpleDwmStyle
fullscreenLayout = named "fullscreen" $ avoidStruts $ noBorders Full
fullscreenVBoxLayout = named "fullVBox" $ noBorders Full
imlayout = named "|#" $ avoidStruts $ withIM (1%4) (Title "Buddy List") $  tabbed_one
dialayout = named "_" $ avoidStruts $ Mirror $ withIM (1%4) (Title "Dia v0.97.1") $  noBorders basicLayout
--gimpL = named "gimp" $ avoidStruts $ withIM (0.15) (Role "gimp-toolbox") $ reflectHoriz $ withIM (0.20) (Role "gimp-dock" ) Full
	-- special layout on certain workspaces 
myLayout =  fullscreen $ chat $ dial $ normal where
normal     =tallLayout ||| wideLayout ||| tabbed_one ||| tabbed_two 
--gimpLayout = onWorkspace "9" gimpL
--circ = onWorkspace "1" circleLayout
chat = onWorkspace "7" imlayout 
dial = onWorkspace "6" dialayout
fullscreen = onWorkspace "0" fullscreenLayout
tabbed_one = named "T1" $ avoidStruts $ tabbed shrinkText defaultTheme
tabbed_two = named "T2" $ avoidStruts $ combineTwo (TwoPane 0.03 0.5) tabbed_one tabbed_one


	------------------------------------------------------------------------
	-- Window rules:

	-- Execute arbitrary actions and WindowSet manipulations when managing
	-- a new window. You can use this to, for example, always float a
	-- particular program, or have a client always appear on a particular
	-- workspace.
	--
	-- To find the property name associated with a program, use
	-- > xprop | grep WM_CLASS
	-- and click on the client you're interested in.
	--
	-- To match on the WM_NAME, you can use 'title' in the same way that
	-- 'className' and 'resource' are used below.
	--
myManageHook = manageDocks <+> myFloatHook <+> myscratchpadManageHook <+> manageHook defaultConfig
myFloatHook = composeAll
	[
    --className =? "Gimp"  --> moveToGimp
  --, className =? "Gimp"  --> unfloat
   className =? "Icedove" --> moveToMail
  , className =? "Thunderbird" --> moveToMail
  , className =? "Eclipse" --> moveToProg
  , className =? "xine" --> moveToFull
  , className =? "mplayer" --> moveToFull
  , className =? "mplayer" --> unfloat
	, resource =? "pidgin" --> moveToIM
	--, [ className =? "Skype" <&&> title ~? "Call with " -?> doSideFloat' CE ]
  , className =? "Pidgin" --> moveToIM
  , className =? "dia" --> moveToDia
	, className =? "Skype" --> moveToIM
	, title =? "irssi"  --> moveToIM
	, title =? "PewPew"  --> doFloat
	, resource =? "Thunderbird" --> moveToMail
	, className =? "Chromium" --> moveToWeb
	, className =? "Firefox" --> moveToWeb
	, manageDocks] where
  unfloat = ask >>= doF . W.sink
  --moveToGimp = doF $ W.shift "9"
  moveToMail = doF $ W.shift "8"
  moveToWeb = doF $ W.shift "2"
  moveToProg = doF $ W.shift "4"
  moveToIM = doF $ W.shift "7"
  moveToDia = doF $ W.shift "6"
  moveToFull = doF $ W.shift "0"
myscratchpadManageHook :: ManageHook
myscratchpadManageHook = scratchpadManageHook (W.RationalRect 0.05 0.625 0.9 0.35)
	-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

	------------------------------------------------------------------------
	-- Startup hook

	-- Perform an arbitrary action each time xmonad starts or is restarted
	-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
	-- per-workspace layout choices.
	--
	-- By default, do nothing.
myStartupHook = setWMName "LG3D"

	------------------------------------------------------------------------
	-- Status bars and logging

	-- Perform an arbitrary action on each internal state change or X event.
	-- See the 'DynamicLog' extension for examples.
	--
	-- To emulate dwm's status bar
	--
	-- > logHook = dynamicLogDzen
	--
--myLogHook = (dynamicLogWithPP $ xmobarPP {
--	ppOutput = System.IO.UTF8.hPutStrLn xmproc,
--	ppTitle = xmobarColor "green" "". shorten 50
--}) >> fadeInactiveLogHook 0xbbbbbbbb

--myLogHook = dynamicLogWithPP byorgeyPP 
	--

	-- Copy of xmobarStrip from darcs version of DynamicLog.hs
	-- http://code.haskell.org/XMonadContrib/XMonad/Hooks/DynamicLog.hs.
--xmobarStrip :: String -> String
--xmobarStrip = strip [] where
--  strip keep x
--    | null x = keep
--    | "<fc=" `isPrefixOf` x = strip keep (drop 1 . dropWhile (/= '>') $ x)
--    | "</fc>" `isPrefixOf` x = strip keep (drop 5 x)
--    | '<' == head x = strip (keep ++ "<") (tail x)
--    | otherwise = let (good, x') = span (/= '<') x in strip (keep ++ good) x'

	------------------------------------------------------------------------
	-- Default Config
	-- A structure containing your configuration settings, overriding
	-- fields in the default config. Any you don't override, will 
	-- use the defaults defined in xmonad/XMonad/Config.hs
	-- 
	-- No need to modify this.
	--
defaults = defaultConfig {
		-- simple stuff
	terminal           = myTerminal,
	focusFollowsMouse  = myFocusFollowsMouse,
	borderWidth        = myBorderWidth,
	modMask            = myModMask,
	--numberlockMask        = myNumlockMask,
	workspaces         = myWorkspaces,
	normalBorderColor  = myNormalBorderColor,
	focusedBorderColor = myFocusedBorderColor,
	--defaultGaps        = myDefaultGaps,

					   -- key bindings
	keys               = myKeys,
	mouseBindings      = myMouseBindings,

				   -- hooks, layouts
	layoutHook         = myLayout,
	manageHook         = myManageHook,
				   --logHook            = myLogHook,
	startupHook        = myStartupHook
	}
--date=do
--  time <- getClockTime >>= toCalendarTime
--  return (hPutStrLn $ formatCalendarTime defaultTimeLocale "%a %b %e %H:%M:%S %Z %Y" time)
------------------------------------------------------------------------
-- Now run xmonad with all the defaults we set up.


pythonDzenPP :: PP
pythonDzenPP = defaultPP {
                      ppCurrent  = dzenColor "#000001" "#000010" . pad
                     , ppVisible  = dzenColor "#000002" "#000020" . pad
                     , ppHidden   = dzenColor "" "" . pad
                     , ppHiddenNoWindows = const ""
                     , ppUrgent   = dzenColor "#000005" "#000050" . pad
                     , ppWsSep    = ""
-- Run xmonad with the settings you specify. No need to modify this.
                     , ppSep      = ""
                     , ppLayout   = 
                                    dzenColor "#000007" "#000070" .
                                    (\ x -> case x of
                                              "tall" -> " TTT "
                                              "wide"   -> " []= "
                                              "single"          -> " [ ] "
                                              "fullscreen"  -> " "
                                              _                      -> pad x
                                    )
                     , ppTitle    = dzenColor "#000006" "#000060" . shorten 20
                     , ppSort = fmap (.scratchpadFilterOutWorkspace) $ ppSort defaultPP
                     }




mydzenPP :: PP
mydzenPP = defaultPP { ppCurrent  = dzenColor "green" "" . pad
                     , ppVisible  = dzenColor "red" "" . pad
                     , ppHidden   = dzenColor "" "" . pad
                     , ppHiddenNoWindows = const ""
                     , ppUrgent   = dzenColor "red" ""
                     , ppWsSep    = ""
                     , ppSep      = ""
                     , ppLayout   = dzenColor "grey" "" .
                                    (\ x -> case x of
                                              "tall" -> " TTT "
                                              "wide"   -> " []= "
                                              "single"          -> " [ ] "
                                              _                      -> pad x
                                    )
                     , ppTitle    = dzenColor "red" "". shorten 20
                     , ppSort = fmap (.scratchpadFilterOutWorkspace) $ ppSort defaultPP
                     }

myxmobarPP = xmobarPP{ 
                        ppUrgent   = xmobarColor "red" ""
                      , ppSort = fmap (.scratchpadFilterOutWorkspace) $ ppSort xmobarPP
                     }

main = do 
  --xmproc <- spawnPipe "xmobar";
  xmproc <- spawnPipe "killall python2.7; dzen_python"
  xmonad $ withUrgencyHook  NoUrgencyHook defaults {
      --logHook   = dynamicLogWithPP $ myxmobarPP {
      logHook   = dynamicLogWithPP $ pythonDzenPP {
					ppOutput = hPutStrLn xmproc 
				}	
}
