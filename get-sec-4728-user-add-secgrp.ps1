
# Get Security Event 4728; 4732 User Added to Security Enabled Global/Local Group

$select = @"
SELECT TimeGenerated, EventId, EventType,
  EXTRACT_TOKEN(Strings, 0, '|') AS MemberName,
  EXTRACT_TOKEN(Strings, 1, '|') AS MemberSid,
  EXTRACT_TOKEN(Strings, 2, '|') AS TargetUserName,
  EXTRACT_TOKEN(Strings, 3, '|') AS TargetDomainName,
  EXTRACT_TOKEN(Strings, 4, '|') AS TargetSid,
  EXTRACT_TOKEN(Strings, 5, '|') AS SubjectUserSid,
  EXTRACT_TOKEN(Strings, 6, '|') AS SubjectUserName,
  EXTRACT_TOKEN(Strings, 7, '|') AS SubjectDomainName,
  EXTRACT_TOKEN(Strings, 8, '|') AS SubjectLogonId,
  EXTRACT_TOKEN(Strings, 9, '|') AS PrivilegeList
INTO 
  sec-4728-user-add-secgrp.csv FROM "c:\winscript\Security.evtx"
WHERE 
  EventId IN (4728;4732)
"@

logparser.exe $select -i:EVT -headers:ON

