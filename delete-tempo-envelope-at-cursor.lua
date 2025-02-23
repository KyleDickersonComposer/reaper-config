local curPos = reaper.GetCursorPosition()
local idx = reaper.FindTempoTimeSigMarker(0, curPos)
if idx >= 0 then
  local retval, timepos, measurepos, beatpos, bpm, ts_num, ts_den, lineartempo = reaper.GetTempoTimeSigMarker(0, idx)
  if retval and math.abs(timepos - curPos) < 0.001 then
    reaper.DeleteTempoTimeSigMarker(0, idx)
  end
end
reaper.UpdateTimeline()
