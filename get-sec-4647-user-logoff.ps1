
# Get Security Event Logoff 4647

$select = @"
SELECT TimeGenerated, EventId, EventType,
  EXTRACT_TOKEN(Strings, 0, '|') AS TargetUserSid,
  EXTRACT_TOKEN(Strings, 1, '|') AS TargetUserName,
  EXTRACT_TOKEN(Strings, 2, '|') AS TargetDomainName,
  EXTRACT_TOKEN(Strings, 3, '|') AS TargetLogonId,
  Message
INTO 
  sec-4647-user-logoff.csv FROM "c:\winscript\Security.evtx"
WHERE 
  EventId IN (4647)
"@

logparser.exe $select -i:EVT -headers:ON


