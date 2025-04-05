function toggle_fabfilter_L2_on_stems()
    local num_tracks = reaper.CountTracks(0)

    -- Loop over normal tracks
    for i = 0, num_tracks - 1 do
        local track = reaper.GetTrack(0, i)
        local retval, track_name = reaper.GetTrackName(track, "")
        
        if track_name:lower():find("stem") then
            toggle_fabfilter_on_track(track, track_name)
        end
    end

    -- Also check master track
    local master_track = reaper.GetMasterTrack(0)
    local retval, master_name = reaper.GetTrackName(master_track, "")
    -- You can just assign a custom label here if needed
    toggle_fabfilter_on_track(master_track, "MASTER")
end

function toggle_fabfilter_on_track(track, track_name)
    local num_fx = reaper.TrackFX_GetCount(track)

    for j = 0, num_fx - 1 do
        local retval, fx_name = reaper.TrackFX_GetFXName(track, j, "")
        
        if fx_name and fx_name:find("Pro%-L 2") then
            local enabled = reaper.TrackFX_GetEnabled(track, j)
            if enabled then
                reaper.TrackFX_SetEnabled(track, j, false)
                reaper.ShowConsoleMsg("Disabled Pro-L 2 on track: " .. track_name .. "\n")
            else
                reaper.TrackFX_SetEnabled(track, j, true)
                reaper.ShowConsoleMsg("Enabled Pro-L 2 on track: " .. track_name .. "\n")
            end
        end
    end
end

reaper.Undo_BeginBlock()
toggle_fabfilter_L2_on_stems()
reaper.Undo_EndBlock("Toggle FabFilter Pro-L 2 on tracks with 'stem' or master", -1)
