
# Get Security Event Logon Terminated 4634

$select = @"
SELECT TimeGenerated, EventId, EventType,
  EXTRACT_TOKEN(Strings, 0, '|') AS TargetUserSid,
  EXTRACT_TOKEN(Strings, 1, '|') AS TargetUserName,
  EXTRACT_TOKEN(Strings, 2, '|') AS TargetDomainName,
  EXTRACT_TOKEN(Strings, 3, '|') AS TargetLogonId,  
  EXTRACT_TOKEN(Strings, 4, '|') AS LogonType  
INTO 
  sec-4634-term-logoff.csv FROM "c:\winscript\Security.evtx"
WHERE 
  EventId IN (4634)
"@

logparser.exe $select -i:EVT -headers:ON


