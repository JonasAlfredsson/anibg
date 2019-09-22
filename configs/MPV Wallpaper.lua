--[[
    Place this file in ~/.config/devilspie2 (or where your install expects it)
    and make sure the path at the top of the `anibg` script points to it.
--]]
if (get_application_name()=="MPV Wallpaper") then
    set_window_type "_NET_WM_WINDOW_TYPE_DESKTOP"; -- Make the window run as a desktop background.
    set_window_geometry2(0,0,1920,1080); -- Size of the window.
    set_window_position2(0,0); -- Position of top left corner of the window.
    stick_window(); -- Make the position fixed.
    set_window_below(); -- Set the current window below all normal windows.
    undecorate_window(); -- Remove all window decorations.
end
