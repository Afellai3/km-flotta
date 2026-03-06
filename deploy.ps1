# deploy.ps1
Write-Host "🔄 Converting TMDL → BIM..."
pbi-tools convert tmdl-output "Model bim dichiarazione km.bim"

Write-Host "✅ Deploy pronto! Apri Power BI Desktop e ricarica."
