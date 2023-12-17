
# Get Security EventId 4697 Service Install


$select = @"
SELECT TimeGenerated, EventId, EventType,
  EXTRACT_TOKEN(Strings, 0, '|') AS SubjectUserSID,
  EXTRACT_TOKEN(Strings, 1, '|') AS SubjectUserName,
  EXTRACT_TOKEN(Strings, 2, '|') AS SubjectDomainName,
  EXTRACT_TOKEN(Strings, 3, '|') AS SubjectLogonId,
  EXTRACT_TOKEN(Strings, 4, '|') AS ServiceName,
  EXTRACT_TOKEN(Strings, 5, '|') AS ServiceFileName,
  EXTRACT_TOKEN(Strings, 6, '|') AS ServiceType,
  EXTRACT_TOKEN(Strings, 7, '|') AS ServiceStartType,
  EXTRACT_TOKEN(Strings, 8, '|') AS ServiceAccount,
  EXTRACT_TOKEN(Strings, 9, '|') AS ClientProcessStartKey,
  EXTRACT_TOKEN(Strings, 10, '|') AS ProcessId,
  EXTRACT_TOKEN(Strings, 11, '|') AS ParentProcessId
INTO 
  sec-4697-srvc-install.csv FROM "c:\winscript\Security.evtx"
WHERE 
  EventId IN (4697)
"@

logparser.exe $select -i:EVT -headers:ON

