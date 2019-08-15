--[[
    This program is a bit special, since the window title in gnome and `wmctrl`
    is "Adobe Flash Player 32,0,0,171", but the function get_application_name()
    will only find "flashplayer". We also need to wait a second before the
    window is ready to be resized, otherwise it will return to the loaded
    content's preferred size.
--]]
if (get_application_name()=="flashplayer") then
    os.execute("sleep " .. tonumber(2)) -- wait 2 seconds
    set_window_type "_NET_WM_WINDOW_TYPE_DESKTOP";
    set_window_geometry2(0,0,3440,1492)
    set_window_position2(0,-92) -- The menu bar's height.
    stick_window();
    set_window_below();
    undecorate_window();
end

--[[
    How to make a search function:
    if (string.find(get_application_name(),"flashplayer")~=nil) then
--]]
