
# Get MS Defender Event 1116 Malware Detected; 1117 Malware Action Taken

$select = @"
SELECT TimeGenerated, EventId, EventType,
  EXTRACT_TOKEN(Strings, 0, '|') AS ProductName,
  EXTRACT_TOKEN(Strings, 1, '|') AS ProductVersion,
  EXTRACT_TOKEN(Strings, 2, '|') AS DetectionID,
  EXTRACT_TOKEN(Strings, 3, '|') AS DetectionTime,
  EXTRACT_TOKEN(Strings, 6, '|') AS ThreatID,
  EXTRACT_TOKEN(Strings, 7, '|') AS ThreatName,
  EXTRACT_TOKEN(Strings, 8, '|') AS SeverityID,
  EXTRACT_TOKEN(Strings, 9, '|') AS SeverityName,
  EXTRACT_TOKEN(Strings, 10, '|') AS CategoryID,
  EXTRACT_TOKEN(Strings, 11, '|') AS CategoryName,
  EXTRACT_TOKEN(Strings, 12, '|') AS FWLink,
  EXTRACT_TOKEN(Strings, 18, '|') AS ProcessName,
  EXTRACT_TOKEN(Strings, 19, '|') AS DetectionUser,
  EXTRACT_TOKEN(Strings, 25, '|') AS ExecutionName
INTO 
  defend-1116-malw-detect.csv FROM "c:\winscript\Microsoft-Windows-Windows-Defender-Operational.evtx"
WHERE 
  EventId IN (1116;1117)
"@

logparser.exe $select -i:EVT -headers:ON

