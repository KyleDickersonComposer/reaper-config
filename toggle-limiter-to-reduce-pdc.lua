function toggle_fabfilter_L2_on_stems()
    local num_tracks = reaper.CountTracks(0)
    
    for i = 0, num_tracks - 1 do
        local track = reaper.GetTrack(0, i)
        local retval, track_name = reaper.GetTrackName(track, "")
        
        if track_name:lower():find("stem") then
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
    end
end

reaper.Undo_BeginBlock()
toggle_fabfilter_L2_on_stems()
reaper.Undo_EndBlock("Toggle FabFilter Pro-L 2 on tracks with 'stem'", -1)
