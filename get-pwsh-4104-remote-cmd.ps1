# Get PowerShellCore 4104 Remote Command

$select = @"
SELECT TimeGenerated, EventId, EventType, ComputerName, SID,
  EXTRACT_TOKEN(Strings, 0, '|') AS MessageNumber,
  EXTRACT_TOKEN(Strings, 1, '|') AS MessageTotal,
  EXTRACT_TOKEN(Strings, 2, '|') AS ScriptBlockText,
  EXTRACT_TOKEN(Strings, 3, '|') AS ScriptBlockId,
  EXTRACT_TOKEN(Strings, 4, '|') AS Path
INTO 
  pwsh-4104-remote-cmd.csv FROM "c:\winscript\PowerShellCore-Operational.evtx"
WHERE 
  EventId IN (4104)
"@

logparser.exe $select -i:EVT -headers:ON