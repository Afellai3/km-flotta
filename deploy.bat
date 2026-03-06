@echo off
echo 🔄 Converting TMDL → BIM...
pbi-tools convert tmdl-output "Model bim dichiarazione km.bim" -overwrite
echo ✅ BIM aggiornato! Ricarica Power BI Desktop.
pause
