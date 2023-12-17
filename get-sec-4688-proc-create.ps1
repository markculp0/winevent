
# Get Security Event 4688 Process Create

$select = @"
SELECT TimeGenerated, EventId, EventType,
  EXTRACT_TOKEN(Strings, 0, '|') AS SubjectUserSID,
  EXTRACT_TOKEN(Strings, 1, '|') AS SubjectUserName,
  EXTRACT_TOKEN(Strings, 2, '|') AS SubjectDomainName,
  EXTRACT_TOKEN(Strings, 3, '|') AS SubjectLogonId,
  EXTRACT_TOKEN(Strings, 4, '|') AS NewProcessId,
  EXTRACT_TOKEN(Strings, 5, '|') AS NewProcessName,
  EXTRACT_TOKEN(Strings, 6, '|') AS TokenElevationType,
  EXTRACT_TOKEN(Strings, 7, '|') AS ProcessId,
  EXTRACT_TOKEN(Strings, 8, '|') AS CommandLine,
  EXTRACT_TOKEN(Strings, 9, '|') AS TargetUserSid,
  EXTRACT_TOKEN(Strings, 10, '|') AS TargetUserName,
  EXTRACT_TOKEN(Strings, 11, '|') AS TargetDomainName,
  EXTRACT_TOKEN(Strings, 12, '|') AS TargetLogonId,
  EXTRACT_TOKEN(Strings, 13, '|') AS ParentProcessName,
  EXTRACT_TOKEN(Strings, 14, '|') AS MandatoryLabel
INTO 
  sec-4688-proc-create.csv FROM "c:\winscript\Security.evtx"
WHERE 
  EventId IN (4688)
"@

logparser.exe $select -i:EVT -headers:ON

