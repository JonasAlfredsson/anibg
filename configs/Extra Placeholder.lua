--[[
    During a brief millisecond, when the `anibg` scripts edits the 'MPV
    Wallpaper.lua' file, there will not exist any valid configuration files in
    the config folder, and this will make devilspie2 terminate with the error:
    "No script files found in the script folder - exiting."

    A workaround is to place this dummy config file in ~/.config/devilspie2
    (or where your install expects it), which will stop it from crashing.
--]]
if (get_application_name()=="A Long and Uncommon Name for a Window") then
    --[[ Do Nothing ]]
end
