@echo off
echo 🔄 Converting TMDL → BIM...
pbi-tools convert -overwrite tmdl-output "Model bim dichiarazione km.bim"
echo ✅ BIM aggiornato! Ricarica Power BI Desktop.
pause
