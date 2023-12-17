
# Get System Event 7030 Service-Desktop Interact; 7045 Service Install

$select = @"
SELECT TimeGenerated, EventId, EventType, ComputerName,
  EXTRACT_TOKEN(Strings, 0, '|') AS ServiceName,
  EXTRACT_TOKEN(Strings, 1, '|') AS ImagePath,
  EXTRACT_TOKEN(Strings, 2, '|') AS ServiceType,
  EXTRACT_TOKEN(Strings, 3, '|') AS StartType,
  EXTRACT_TOKEN(Strings, 4, '|') AS AccountName
INTO 
  sys-7045-srvc-install.csv FROM "c:\winscript\System.evtx"
WHERE 
  EventId IN (7030;7045)
"@

logparser.exe $select -i:EVT -headers:ON

