
# Get Security Event 4720 User Account Created

$select = @"
SELECT TimeGenerated, EventId, EventType,
  EXTRACT_TOKEN(Strings, 0, '|') AS TargetUserName,
  EXTRACT_TOKEN(Strings, 1, '|') AS TargetDomainName,
  EXTRACT_TOKEN(Strings, 2, '|') AS TargetSid,
  EXTRACT_TOKEN(Strings, 3, '|') AS SubjectUserSid,
  EXTRACT_TOKEN(Strings, 4, '|') AS SubjectUserName,
  EXTRACT_TOKEN(Strings, 5, '|') AS SubjectDomainName,
  EXTRACT_TOKEN(Strings, 6, '|') AS SubjectLogonId,
  EXTRACT_TOKEN(Strings, 7, '|') AS PrivilegeList,
  EXTRACT_TOKEN(Strings, 8, '|') AS SamAccountName,
  EXTRACT_TOKEN(Strings, 9, '|') AS DisplayName,
  EXTRACT_TOKEN(Strings, 10, '|') AS UserPrincipalName,
  EXTRACT_TOKEN(Strings, 11, '|') AS HomeDirectory,
  EXTRACT_TOKEN(Strings, 12, '|') AS HomePath,
  EXTRACT_TOKEN(Strings, 13, '|') AS ScriptPath,
  EXTRACT_TOKEN(Strings, 14, '|') AS ProfilePath
INTO 
  sec-4720-user-create.csv FROM "c:\winscript\Security.evtx"
WHERE 
  EventId IN (4720)
"@

logparser.exe $select -i:EVT -headers:ON

