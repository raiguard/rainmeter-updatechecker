--------------------------------------------------
-- Update Checker for Rainmeter - EXAMPLE VERSION
-- Version 2.0.0
-- By iamanai
--------------------------------------------------
--
-- Release Notes:
-- v2.1.0 - Fixed oversight where if the user is on a development version for an
--          outdated release, it would not return UpdateAvailable(), added
--          'ParsingError' return
-- v2.0.0 - Removed dependancy on an output meter in favor of hard-coded actions
-- v1.0.1 - Optimized gmatch function, more debug functionality
-- v1.0.0 - Initial release
--

isDbg = false

function Initialize() end

function Update() end

-- up-to-date - hard-coded actions
function UpToDate()

  SKIN:Bang('!SetOption', 'UpdateStatusString', 'Text', 'Up-to-date')
  SKIN:Bang('!UpdateMeter', 'UpdateStatusString')
  SKIN:Bang('!Redraw')

end

-- update available - hard-coded actions
function UpdateAvailable()

  SKIN:Bang('!SetOption', 'UpdateStatusString', 'Text', 'Update available!')
  SKIN:Bang('!UpdateMeter', 'UpdateStatusString')
  SKIN:Bang('!Redraw')

end

-- development version - hard-coded actions
function DevelopmentVersion()

  SKIN:Bang('!SetOption', 'UpdateStatusString', 'Text', 'Development version')
  SKIN:Bang('!UpdateMeter', 'UpdateStatusString')
  SKIN:Bang('!Redraw')

end

-- when the measure throws a connection error
function ConnectError()

  SKIN:Bang('!SetOption', 'UpdateStatusString', 'Text', 'CONNECTION ERROR')
  SKIN:Bang('!SetOption', 'UpdateStatusString', 'FontColor', '#colorConnectError#')
  SKIN:Bang('!UpdateMeter', 'UpdateStatusString')
  SKIN:Bang('!Redraw')

end

-- parsing error - hard-coded actions
function ParsingError()

  SKIN:Bang('!SetOption', 'UpdateStatusString', 'Text', 'PARSING ERROR')
  SKIN:Bang('!SetOption', 'UpdateStatusString', 'FontColor', '#colorConnectError#')
  SKIN:Bang('!UpdateMeter', 'UpdateStatusString')
  SKIN:Bang('!Redraw')

end

-- thrown by the webparser measure when the fetch is successful
function CheckForUpdate(cVersion, rVersion)

  LogHelper('rVersion: ' .. rVersion, 'Debug')

  cVerTable = {}
  for match in cVersion:gmatch('%d+') do
    table.insert(cVerTable, match)
    LogHelper('cVerTable: ' .. match, 'Debug')
  end

  rVerTable = {}
  for match in rVersion:gmatch('%d+') do
    table.insert(rVerTable, match)
    LogHelper('rVerTable: ' .. match, 'Debug')
  end

  LogHelper('cVerTable length: ' .. tableLength(cVerTable) .. ' rVerTable length: ' .. tableLength(rVerTable), 'Debug')

  if tableLength(cVerTable) < 3 then ParsingError() LogHelper('Problem parsing local version string', 'Error') return nil end
  if tableLength(rVerTable) < 3 then ParsingError() LogHelper('Problem parsing remote version string', 'Error') return nil end

  r1 = cVerTable[1] - rVerTable[1]
  r2 = cVerTable[2] - rVerTable[2]
  r3 = cVerTable[3] - rVerTable[3]

  if r1 < 0 or r2 < 0 or r3 < 0 then
    UpdateAvailable()
  elseif r1 == 0 and r2 == 0 and r3 == 0 then
    if tableLength(cVerTable) == 4 then
      DevelopmentVersion()
    else
      UpToDate()
    end
  elseif r1 > 0 or r2 > 0 or r3 > 0 then
    DevelopmentVersion()
  end

end

-- returns the number of entries in the given table
function tableLength(T)

  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count

end

-- function to make logging messages less cluttered
function LogHelper(message, type)

	if isDbg == true then
		SKIN:Bang("!Log", 'UpdateChecker.lua: ' .. message, type)
	elseif type ~= 'Debug' and type ~= nil then
		SKIN:Bang("!Log", 'UpdateChecker.lua: ' .. message, type)
	end

end
