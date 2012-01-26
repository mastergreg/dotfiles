--[[
Ring Meters by londonali1010 (2009) mod by arpinux

This script draws percentage meters as rings. It is fully customisable; all options are described in the script.

IMPORTANT: if you are using the 'cpu' function, it will cause a segmentation fault if it tries to draw a ring straight away. The if statement on line 129 uses a delay to make sure that this doesn't happen. It calculates the length of the delay by the number of updates since Conky started. Generally, a value of 5s is long enough, so if you update Conky every 1s, use update_num>5 in that if statement (the default). If you only update Conky every 2s, you should change it to update_num>3; conversely if you update Conky every 0.5s, you should use update_num>10. ALSO, if you change your Conky, is it best to use "killall conky; conky" to update it, otherwise the update_num will not be reset and you will get an error.

To call this script in Conky, use the following (assuming that you save this script to ~/scripts/rings.lua):
	lua_load ~/scripts/rings.lua
	lua_draw_hook_pre ring_stats
]]

settings_table = {
	{
		name='time',
		arg='%I',
		max=12,
		bg_colour=0xffffff,
		bg_alpha=0,
        --		fg_colour=0x74C2B7,
        fg_colour=0x5054F8,
		fg_alpha=0.8,
		x=113, y=92,
		radius=25,
		thickness=15,
		angle=0
	},
	{
		name='time',
		arg='%M',
		max=60,
		bg_colour=0x000000,
		bg_alpha=0.1,
		fg_colour=0xffffff,
		fg_alpha=0.6,
		x=113, y=92,
		radius=40,
		thickness=10,
		angle=0
	},
	{
		name='time',
		arg='%S',
		max=60,
		bg_colour=0x000000,
		bg_alpha=0.2,
		fg_colour=0x4D4D4D,
		fg_alpha=0.8,
		x=249.5, y=170,
		radius=36,
		thickness=8,
		angle=35
	},
	{
		name='swapperc',
		arg='',
		max=100,
		bg_colour=0x000000,
		bg_alpha=0.1,
		fg_colour=0x000000,
		fg_alpha=0.6,
		x=63, y=255,
		radius=54,
		thickness=3,
		angle=51
	},
	{
		name='fs_used_perc',
		arg='/',
		max=100,
		bg_colour=0xffffff,
		bg_alpha=0,
		fg_colour=0xffffff,
		fg_alpha=0.2,
		x=63, y=255,
		radius=24,
		thickness=16,
		angle=0
	},
	{
		name='fs_used_perc',
		arg='/home',
		max=100,
		bg_colour=0xffffff,
		bg_alpha=0,
		fg_colour=0xffffff,
		fg_alpha=0.4,
		x=63, y=255,
		radius=42,
		thickness=13,
		angle=0
	},
}

require 'cairo'

function rgb_to_r_g_b(colour,alpha)
	return ((colour / 0x10000) % 0x100) / 255., ((colour / 0x100) % 0x100) / 255., (colour % 0x100) / 255., alpha
end

function draw_ring(t, pt)
	if conky_window==nil then return end
	local w,h=conky_window.width,conky_window.height
	local cs=cairo_xlib_surface_create(conky_window.display,conky_window.drawable,conky_window.visual,w,h)
	
	cr=cairo_create(cs)
	
	local xc,yc,ring_r,ring_w,angle=pt['x'],pt['y'],pt['radius'],pt['thickness'],pt['angle']
	local bgc, bga, fgc, fga=pt['bg_colour'], pt['bg_alpha'], pt['fg_colour'], pt['fg_alpha']

	local angle_0=angle*(2*math.pi/360)-math.pi/2
	local t_arc=t*2*math.pi

	-- Draw background ring

	cairo_arc(cr,xc,yc,ring_r,0,2*math.pi)
	cairo_set_source_rgba(cr,rgb_to_r_g_b(bgc,bga))
	cairo_set_line_width(cr,ring_w)
	cairo_stroke(cr)
	
	-- Draw indicator ring

	cairo_arc(cr,xc,yc,ring_r,angle_0,angle_0+t_arc)
	cairo_set_source_rgba(cr,rgb_to_r_g_b(fgc,fga))
	cairo_stroke(cr)		
	
	cairo_destroy(cr)
	cr = nil
end

function conky_cairo_cleanup()
	cairo_surface_destroy(cs)
	cs = nil
end

function conky_ring_stats()
	local function setup_rings(pt)
		local str=''
		local value=0
		
		str=string.format('${%s %s}',pt['name'],pt['arg'])
		str=conky_parse(str)
		
		value=tonumber(str)
		pct=value/pt['max']
		
		draw_ring(pct,pt)
	end
	
	-- Check that Conky has been running for at least 5s
	
	local updates=conky_parse('${updates}')
	update_num=tonumber(updates)
	
	if update_num>5 then
		for i in pairs(settings_table) do
			setup_rings(settings_table[i])
		end
	end
end
