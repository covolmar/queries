CREATE VIEW SignalAttributeView AS
SELECT KommentarText, Wert, 
CASE WHEN HatZeit = 1 THEN 'x' ELSE '' END AS Zeiteinbindung,
CASE WHEN HatBackup = 1 THEN 'x' ELSE '' END AS HatBackup,
CASE WHEN HatImpulsBefehl = 1 THEN 'x' ELSE '' END AS Impulsbefehl,
CASE WHEN HatPrivileg = 1 THEN 'x' ELSE '' END AS ÜbertragungMitPrio,
CASE WHEN HatRedundanz = 1 THEN '' ELSE 'x' END AS NichtRedundant
FROM Signal