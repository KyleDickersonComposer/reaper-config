local curPos = reaper.GetCursorPosition()
local ret, input = reaper.GetUserInputs("Set Time Signature", 1, "Time Signature (e.g. 4/4)", "")
if not ret then return end
local num, den = input:match("^(%d+)%/(%d+)$")
if not num or not den then reaper.ShowMessageBox("Invalid input", "Error", 0) return end
num, den = tonumber(num), tonumber(den)
local tempo = reaper.Master_GetTempo()
reaper.SetTempoTimeSigMarker(0, -1, curPos, 0, 0, tempo, num, den, false)
reaper.UpdateTimeline()

