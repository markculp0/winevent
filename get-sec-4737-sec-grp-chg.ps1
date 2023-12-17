
# Get Security Event 4735; 4737; 4755 Security Enabled Local/Global Group Change

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
  EXTRACT_TOKEN(Strings, 9, '|') AS SidHistory
INTO 
  sec-4737-sec-grp-chg.csv FROM "c:\winscript\Security.evtx"
WHERE 
  EventId IN (4735;4737;4755)
"@

logparser.exe $select -i:EVT -headers:ON

