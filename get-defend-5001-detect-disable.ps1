
# Get MS Defender Event 5000 Malware Detect Enabled; 5001 Malware Detect Disabled

$select = @"
SELECT TimeGenerated, EventId, EventType, ComputerName, SID,
  EXTRACT_TOKEN(Strings, 0, '|') AS ProductName,
  EXTRACT_TOKEN(Strings, 1, '|') AS ProductVersion
INTO 
  defend-5001-detect-disable.csv FROM "c:\winscript\Microsoft-Windows-Windows-Defender-Operational.evtx"
WHERE 
  EventId IN (5000;5001)
"@

logparser.exe $select -i:EVT -headers:ON

