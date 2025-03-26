reaper.Undo_BeginBlock()

-- Deselect all items
reaper.Main_OnCommand(40297, 0)  -- Unselect all items

-- Deselect all tracks
reaper.Main_OnCommand(40289, 0)  -- Unselect all tracks

reaper.Undo_EndBlock("Clear all track and item selections", -1)

