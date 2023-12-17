
# Get Security Event Logoff 4625

$select = @"
SELECT TimeGenerated, EventId, EventType,
  EXTRACT_TOKEN(Strings, 0, '|') AS SubjectUserSID,
  EXTRACT_TOKEN(Strings, 1, '|') AS SubjectUserName,
  EXTRACT_TOKEN(Strings, 2, '|') AS SubjectDomainName,
  EXTRACT_TOKEN(Strings, 3, '|') AS SubjectLogonId,
  EXTRACT_TOKEN(Strings, 4, '|') AS TargetUserSid,
  EXTRACT_TOKEN(Strings, 5, '|') AS TargetUserName,
  EXTRACT_TOKEN(Strings, 6, '|') AS TargetDomainName,
  EXTRACT_TOKEN(Strings, 7, '|') AS Status,
  EXTRACT_TOKEN(Strings, 8, '|') AS FailureReason,
  EXTRACT_TOKEN(Strings, 9, '|') AS SubStatus,
  EXTRACT_TOKEN(Strings, 10, '|') AS LogonType,
  EXTRACT_TOKEN(Strings, 11, '|') AS LogonProcessName,
  EXTRACT_TOKEN(Strings, 12, '|') AS AuthenPkgName,
  EXTRACT_TOKEN(Strings, 13, '|') AS WorkstationName,
  EXTRACT_TOKEN(Strings, 17, '|') AS ProcessId,
  EXTRACT_TOKEN(Strings, 18, '|') AS ProcessName,
  EXTRACT_TOKEN(Strings, 19, '|') AS IpAddress,
  EXTRACT_TOKEN(Strings, 20, '|') AS IpPort
INTO 
  sec-4625-logoff.csv FROM "c:\winscript\Security.evtx"
WHERE 
  EventId IN (4625)
"@

logparser.exe $select -i:EVT -headers:ON


