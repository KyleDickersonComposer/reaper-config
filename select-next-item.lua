reaper.Undo_BeginBlock()

local selected_item = false
local num_items = reaper.CountMediaItems(0)

for i = 0, num_items - 1 do
    local item = reaper.GetMediaItem(0, i)
    if reaper.IsMediaItemSelected(item) then
        selected_item = true
        break
    end
end

if selected_item then
    local action = reaper.NamedCommandLookup("_SWS_SELNEXTITEM2")
    if action ~= 0 then
        reaper.Main_OnCommand(action, 0)
        reaper.Main_OnCommand(reaper.NamedCommandLookup("_SWS_SELTRKWITEM"), 0)
    end
else
    reaper.Main_OnCommand(reaper.NamedCommandLookup("_XENAKIOS_SELFIRSTITEMSOFTRACKS"), 0)
end

reaper.Undo_EndBlock("Select next item or first item on track", -1)

