# Get Windows PowerShell 800 Pipeline Execution

$select = @"
SELECT TimeGenerated, EventId, EventType, ComputerName, Message
INTO 
  pwsh-800-pipeline-exe.csv FROM 'c:\winscript\Windows PowerShell.evtx'
WHERE 
  EventId IN (800)
"@

logparser.exe $select -i:EVT -headers:ON