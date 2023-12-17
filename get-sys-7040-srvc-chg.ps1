
# Get System Event 7040 IPSEC Service Setting Changed

$select = @"
SELECT TimeGenerated, EventId, EventType, ComputerName, SID,
  EXTRACT_TOKEN(Strings, 0, '|') AS Description,
  EXTRACT_TOKEN(Strings, 1, '|') AS ChgFrom,
  EXTRACT_TOKEN(Strings, 2, '|') AS ChgTo,
  EXTRACT_TOKEN(Strings, 3, '|') AS Service,
  Message
INTO 
  sys-7040-srvc-chg.csv FROM "c:\winscript\System.evtx"
WHERE 
  EventId IN (7040)
"@

logparser.exe $select -i:EVT -headers:ON

