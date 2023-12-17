
# Get Security Event Logon Specific Creds 4648

$select = @"
SELECT TimeGenerated, EventId, EventType,
  EXTRACT_TOKEN(Strings, 0, '|') AS SubjectUserSID,
  EXTRACT_TOKEN(Strings, 1, '|') AS SubjectUserName,
  EXTRACT_TOKEN(Strings, 2, '|') AS SubjectDomainName,
  EXTRACT_TOKEN(Strings, 3, '|') AS SubjectLogonId,
  EXTRACT_TOKEN(Strings, 4, '|') AS LogonGuid,
  EXTRACT_TOKEN(Strings, 5, '|') AS TargetUserName,
  EXTRACT_TOKEN(Strings, 6, '|') AS TargetDomainName,
  EXTRACT_TOKEN(Strings, 7, '|') AS TargetLogonGuid,
  EXTRACT_TOKEN(Strings, 8, '|') AS TargetServerName,
  EXTRACT_TOKEN(Strings, 9, '|') AS TargetInfo,
  EXTRACT_TOKEN(Strings, 10, '|') AS ProcessId,
  EXTRACT_TOKEN(Strings, 11, '|') AS ProcessName,
  EXTRACT_TOKEN(Strings, 12, '|') AS IpAddress,
  EXTRACT_TOKEN(Strings, 13, '|') AS IpPort,
  Message
INTO 
  sec-4648-cred-logon.csv FROM "c:\winscript\Security.evtx"
WHERE 
  EventId IN (4648)
"@

logparser.exe $select -i:EVT -headers:ON


