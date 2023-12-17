
# Get Security Event Logon Special Privileges 4672

$select = @"
SELECT TimeGenerated, EventId, EventType,
  EXTRACT_TOKEN(Strings, 0, '|') AS SubjectUserSID,
  EXTRACT_TOKEN(Strings, 1, '|') AS SubjectUserName,
  EXTRACT_TOKEN(Strings, 2, '|') AS SubjectDomainName,
  EXTRACT_TOKEN(Strings, 3, '|') AS SubjectLogonId,
  EXTRACT_TOKEN(Strings, 4, '|') AS PrivilegeList,
  Message
INTO 
  sec-4672-spec-logon.csv FROM "c:\winscript\Security.evtx"
WHERE 
  EventId IN (4672)
"@

logparser.exe $select -i:EVT -headers:ON


