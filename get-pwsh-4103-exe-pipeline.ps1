# Get PowerShellCore 4103 Executing Pipeline

$select = @"
SELECT TimeGenerated, EventId, EventType, ComputerName, SID,
  EXTRACT_TOKEN(Strings, 0, '|') AS ContextInfo,
  EXTRACT_TOKEN(Strings, 1, '|') AS UserData,
  EXTRACT_TOKEN(Strings, 2, '|') AS Payload  
INTO 
  pwsh-4103-exe-pipeline.csv FROM "c:\winscript\PowerShellCore-Operational.evtx"
WHERE 
  EventId IN (4103)
"@

logparser.exe $select -i:EVT -headers:ON

