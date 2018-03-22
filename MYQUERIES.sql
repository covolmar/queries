USE LoeweNew
USE Furli
USE loewe213inklSQL

SELECT Signal.Id, SignalFullName.Name 
FROM Signal
JOIN SignalFullName on Signal.Id = SignalFullName.Id


SELECT S.Id AS SIGNAL_ID, KKS0, KKS1, KKS2, KKS3, S.Name AS KKS4, BEREICH, 
BAUWERK, FUNKTION, ELEMENT, S.IndexText AS SIGNAL_INDEX
FROM Signal S
INNER JOIN(
SELECT KKS0.Name AS KKS0, KKS0.Bezeichnung AS BEREICH, 
KKS1.Name AS KKS1, KKS1.Bezeichnung AS BAUWERK,
KKS2.Name AS KKS2, KKS2.Bezeichnung AS FUNKTION,
KKS3.Name AS KKS3, KKS3.Bezeichnung AS ELEMENT,
KKS3.Id AS KKS3_ID -- JOIN REFERENCE WITH SIGNAL TABLE!!!
FROM AnlagenObjekt KKS0, AnlagenObjekt KKS1, AnlagenObjekt KKS2, AnlagenObjekt KKS3 
WHERE KKS0.Id = KKS1.ParentAnlagenObjektId
AND KKS1.Id = KKS2.ParentAnlagenObjektId
AND KKS2.Id = KKS3.ParentAnlagenObjektId
) A ON A.KKS3_ID = S.AnlagenObjektId




SELECT DISTINCT First.MFEText AS MFETEXT_0, Second.MFEText AS MFETEXT_1, Third.MFEText AS MFETEXT_2, First.SignalId AS SIGNAL_ID
FROM MFEText First, MFEText Second, MFEText Third
WHERE First.Nummer = 0
AND Second.Nummer = 1
AND Third.Nummer = 2
ORDER BY SIGNAL_ID


SELECT R.MFEText, F.MFEText, R.SignalId
FROM MFEText R, MFEText F
WHERE R.Nummer = 0 AND F.Nummer = 1 AND R.SignalId = F.SignalId

SELECT R.MFEText, F.MFEText, R.SignalId
FROM MFEText R, MFEText F
WHERE R.Nummer BETWEEN 0 AND 3
AND R.SignalId = F.SignalId


-- Signal Name View---------------------------------------------------------------------------------------

SELECT KKS0, KKS1, KKS2, KKS3, S.Name AS KKS4, BEREICH, BAUWERK, FUNKTION, ELEMENT, S.IndexText AS SIGNAL_INDEX, S.Id AS SIGNAL_ID
FROM Signal S
INNER JOIN(
SELECT KKS0.Name AS KKS0, KKS0.Bezeichnung AS BEREICH, 
KKS1.Name AS KKS1, KKS1.Bezeichnung AS BAUWERK,
KKS2.Name AS KKS2, KKS2.Bezeichnung AS FUNKTION,
KKS3.Name AS KKS3, KKS3.Bezeichnung AS ELEMENT,
KKS3.Id AS KKS3_ID -- JOIN REFERENCE WITH SIGNAL TABLE!!!
FROM AnlagenObjekt KKS0, AnlagenObjekt KKS1, AnlagenObjekt KKS2, AnlagenObjekt KKS3 
WHERE KKS0.Id = KKS1.ParentAnlagenObjektId
AND KKS1.Id = KKS2.ParentAnlagenObjektId
AND KKS2.Id = KKS3.ParentAnlagenObjektId
) A ON A.KKS3_ID = S.AnlagenObjektId
INNER JOIN(
SELECT HW.HWModulId as HardwareModul_Id, HW.DPNummer as DPNummer, HW.IstInvertiert as IstInvertiert,
HW.DPTypId as DPTyp, HW.DPModusId as DPModus, HW.AnzahlDP as AnzahlDP, HW.VariablenId as VariablenId
FROM HW_DPSignal HW
) B ON  B.VariablenId = S.Id




---------------------------------- MFE-VIEW--------------------------------------------------
SELECT MFE0.MFEText_0, MFE1.MFEText_1, MFE2.MFEText_2, MFE3.MFEText_3,
MFE4.MFEText_4, MFE5.MFEText_5, MFE6.MFEText_6, MFE7.MFEText_7, MFE0.Signal_Id AS SIGNAL_ID
FROM 
(
	SELECT MFEText AS MFEText_0, SignalId AS Signal_Id 
	FROM MFEText
	WHERE Nummer = 0
) MFE0
LEFT OUTER JOIN
(
	SELECT MFEText AS MFEText_1, SignalId AS Signal_Id 
	FROM MFEText
	WHERE Nummer = 1
) MFE1
ON MFE0.Signal_Id = MFE1.Signal_Id
LEFT OUTER JOIN 
(
	SELECT MFEText AS MFEText_2, SignalId AS Signal_Id 
	FROM MFEText
	WHERE Nummer = 2
) MFE2
ON MFE1.Signal_Id = MFE2.Signal_Id
LEFT OUTER JOIN 
(
	SELECT MFEText AS MFEText_3, SignalId AS Signal_Id 
	FROM MFEText
	WHERE Nummer = 3
) MFE3
ON MFE2.Signal_Id = MFE3.Signal_Id
LEFT OUTER JOIN 
(
	SELECT MFEText AS MFEText_4, SignalId AS Signal_Id 
	FROM MFEText
	WHERE Nummer = 4
) MFE4
ON MFE3.Signal_Id = MFE4.Signal_Id
LEFT OUTER JOIN 
(
	SELECT MFEText AS MFEText_5, SignalId AS Signal_Id 
	FROM MFEText
	WHERE Nummer = 5
) MFE5
ON MFE4.Signal_Id = MFE5.Signal_Id
LEFT OUTER JOIN 
(
	SELECT MFEText AS MFEText_6, SignalId AS Signal_Id 
	FROM MFEText
	WHERE Nummer = 6
) MFE6
ON MFE5.Signal_Id = MFE6.Signal_Id
LEFT OUTER JOIN 
(
	SELECT MFEText AS MFEText_7, SignalId AS Signal_Id 
	FROM MFEText
	WHERE Nummer = 7
) MFE7
ON MFE6.Signal_Id = MFE7.Signal_Id



--------VIEW Parameter----------------------------------------------
SELECT S.KonfigurationId AS Konfiguration, Q.StaNr AS Station, Q.ParaNr AS ParaBlockNr, 
Q.ParaMin AS ParaMin, Q.ParaMax AS ParaMax, Q.ParaNKS AS Nachkommastellen
FROM VarQuSe Q
LEFT OUTER JOIN Station S
ON S.Id = Q.StaNr



SELECT MFEText, SignalId
FROM MFEText
WHERE Nummer BETWEEN 0 AND 3

SELECT * FROM MFEText


-----------View M1 Interface-----------------------------
SELECT S.Id as Signal_Id, V.Id 
FROM Signal S, VarQuSe V


SELECT HW.HWModulId as HardwareModul_Id, HW.DPNummer as DPNummer, HW.IstInvertiert as IstInvertiert,
HW.DPTyp as DPTyp, HW.DPModus as DPModus, HW.AnzahlDP as AnzahlDP
FROM HW_DPSignal


-----------View Signal Attribute-----------------------------

SELECT Id as Signal_Id, KommentarText as Kommentar, HatZeit as Zeiteinbindung, HatBackup, 
HatImpulsBefehl, HatFWPrio as HatÜbertragungMitPrio, HatRedundanz
FROM Signal



-----------View Davos-----------------------------

SELECT Id as Signal_Id, DavosVerdichtung, DavosIntervall, DavosElemente 
FROM Signal
-----------------------------------------------------------------

DROP VIEW SignalMitBezeichnung

SELECT * FROM SignalFullName

SELECT * 
FROM SignalFullName S
INNER JOIN Variable V
	ON S.Id=V.SignalId
INNER JOIN Station Sta
	ON V.StationId=Sta.Id
WHERE S.Name='1.1MYA10.EE112X.XK06.RM00'


SELECT * FROM Variable WHERE SignalId=1859042


SELECT AO0, AO1, AO2, AO3, S.Name AS SO, BEREICH, BAUWERK, FUNKTION, ELEMENT, S.IndexText AS INDEX_TEXT, ST.Name AS Typ, S.Id AS SIGNAL_ID
FROM Signal S
INNER JOIN(
	SELECT KKS0.Name AS AO0, KKS0.Bezeichnung AS BEREICH, 
	KKS1.Name AS AO1, KKS1.Bezeichnung AS BAUWERK,
	KKS2.Name AS AO2, KKS2.Bezeichnung AS FUNKTION,
	KKS3.Name AS AO3, KKS3.Bezeichnung AS ELEMENT,
	KKS3.Id AS KKS3_ID
	FROM AnlagenObjekt KKS0, AnlagenObjekt KKS1, AnlagenObjekt KKS2, AnlagenObjekt KKS3 
	WHERE KKS0.Id = KKS1.ParentAnlagenObjektId
	AND KKS1.Id = KKS2.ParentAnlagenObjektId
	AND KKS2.Id = KKS3.ParentAnlagenObjektId
) A ON A.KKS3_ID = S.AnlagenObjektId
INNER JOIN SignalTyp ST
ON ST.Id = S.TypId

SELECT * 
FROM SignalMitBezeichnung S
INNER JOIN Variable V
ON S.SIGNAL_ID = V.SignalId

SELECT * 
FROM SignalMitBezeichnung S
INNER JOIN Variable V
ON S.SIGNAL_ID = V.SignalId
WHERE S.SIGNAL_ID = 1859042

SELECT *
FROM HW_DPMerkmal H
INNER JOIN HW_DPSignal S
ON H.HWDPSignalId = S.Id
WHERE S.VariablenId = 1875068



SELECT *
FROM SignalMitBezeichnung SMB
LEFT OUTER JOIN MFE_Texte T
ON T.Signal_Id = SMB.SIGNAL_ID
LEFT OUTER JOIN
(
	SELECT K.Name AS KonfigurationsName, K.Nummer AS KonfigurationsNummer, S.Name AS Stationsname, 
	S.Nummer AS StationsNummer, HWDPS.DPModus AS Messsignal, HWDPS.IstInvertiert AS E_A, 
	HWM.SteckplatzNummer AS Modul_Steckplatznummer, HWM.ModulTyp AS ModulnameTYP, HWDPS.DPNummer AS DP_Nummer,
	HWDPS.AnzahlDP AS Anzahl_DP, V.Id AS VariablenId, V.SignalId AS SIGNAL_ID
	FROM Variable V
	INNER JOIN Station S
	ON S.Id = V.StationId
	INNER JOIN Konfiguration K
	ON S.KonfigurationId = K.Id
	INNER JOIN HW_DPSignal HWDPS
	ON V.Id = HWDPS.VariablenId
	INNER JOIN HWModul HWM
	ON HWM.Id = HWDPS.HWModulId
) SUBQUERY ON SMB.SIGNAL_ID = SUBQUERY.SIGNAL_ID
WHERE SUBQUERY.VariablenId = 1875068

SELECT * FROM SignalMitBezeichnung


SELECT K.Nummer AS Konfigurations_Nr, S.Nummer AS Stations_Nr, HWM.SteckplatzNummer AS Modul_Steckplatznummer, 
HWDPS.DPNummer AS DP_Nummer, HWDPS.AnzahlDP AS Anzahl_DP,
CASE WHEN HWDPS.DPTypId = 0 OR HWDPS.DPTypId = 2 THEN 'E' ELSE 'A' END AS DPTyp_EA,
CASE WHEN HWDPS.IstInvertiert = 1 THEN 'x' ELSE ' ' END AS Inv, DPM.Name AS DPMODUSTEMP,
CASE 
	WHEN DPM.Name = 'PT100' THEN 'PT100_' + CAST(SourceMerkmalLeiter.AnzahlLeiter AS VARCHAR(10))
	WHEN DPM.Name = 'PT1000' THEN 'PT1000_' + CAST(SourceMerkmalLeiter.AnzahlLeiter AS VARCHAR(10))
	WHEN DPM.Name = 'Lampenkontrolle Ausgang' THEN SourceMerkmalLampenkontrolle.LampenKontrolle
	WHEN DPM.Name = 'Alarm-Ausgang (S/SA)' THEN SourceMerkmalBlinkMode.BlinkMode
	WHEN (DPM.Name = 'Messwert Eingang' OR DPM.Name = 'Messwert Ausgang') AND (HWDPS.DPTypId = 0 OR HWDPS.DPTypId = 1) THEN SourceMerkmalMesswertCode.MesswertCode
	WHEN DPM.Name = 'Digital Ein-/Ausgang' AND HWDPS.DPTypId = 1 AND LEN(SourceMerkmalLampenkontrolle.LampenKontrolle) > 0 THEN SourceMerkmalLampenkontrolle.LampenKontrolle
	WHEN DPM.Name = 'Digital Ein-/Ausgang' AND HWDPS.DPTypId = 1 AND SourceMerkmalLampenkontrolle.LampenKontrolle IS NULL THEN 'D1'
	WHEN DPM.Name = 'Digital Ein-/Ausgang' AND HWDPS.DPTypId = 0 THEN ' '
	ELSE DPM.Name
END AS DPModus,
MT.Name AS ModulTYP, SourceM.Mittelwert, SourceG.DigitalesFilter,
SourceT.Transferzeit, SourceF.Fehlerintegrator,  V.Id AS VariablenId, V.SignalId AS SIGNAL_ID
FROM Variable V
INNER JOIN Station S
ON S.Id = V.StationId
INNER JOIN Konfiguration K
ON S.KonfigurationId = K.Id
INNER JOIN HW_DPSignal HWDPS
ON V.Id = HWDPS.VariablenId
INNER JOIN DPModus DPM
ON HWDPS.DPModusId = DPM.Id AND HWDPS.DPTypId = DPM.DPTypId
INNER JOIN DPTyp DT
ON DT.Id = HWDPS.DPTypId
INNER JOIN HWModul HWM
ON HWM.Id = HWDPS.HWModulId
INNER JOIN ModulTyp MT
ON MT.Id = HWM.ModulTypId
LEFT OUTER JOIN
(
	SELECT H.Wert AS Mittelwert, S.VariablenId
	FROM HW_DPMerkmal H
	INNER JOIN HW_DPSignal S
	ON H.HWDPSignalId = S.Id
	WHERE H.Name = 'Mittelwert'
) SourceM ON SourceM.VariablenId = V.Id
LEFT OUTER JOIN
(
	SELECT H.Wert AS DigitalesFilter, S.VariablenId
	FROM HW_DPMerkmal H
	INNER JOIN HW_DPSignal S
	ON H.HWDPSignalId = S.Id
	WHERE H.Name = 'GrenzFrequenz'
) SourceG ON SourceG.VariablenId = V.Id
LEFT OUTER JOIN
(
	SELECT H.Wert AS Transferzeit, S.VariablenId
	FROM HW_DPMerkmal H
	INNER JOIN HW_DPSignal S
	ON H.HWDPSignalId = S.Id
	WHERE H.Name = 'Transferzeit'
) SourceT ON SourceT.VariablenId = V.Id
LEFT OUTER JOIN
(
	SELECT H.Wert AS Fehlerintegrator, S.VariablenId
	FROM HW_DPMerkmal H
	INNER JOIN HW_DPSignal S
	ON H.HWDPSignalId = S.Id
	WHERE H.Name = 'FehlerIntegrator'
) SourceF ON SourceF.VariablenId = V.Id
LEFT OUTER JOIN
(
	SELECT 
	CASE 
		WHEN H.Wert = 0 THEN '2' --Leiter
		WHEN H.Wert = 1 THEN '3' --Leiter
		WHEN H.Wert = 2 THEN '4' --Leiter
	END AS AnzahlLeiter, 
	S.VariablenId
	FROM HW_DPMerkmal H
	INNER JOIN HW_DPSignal S
	ON H.HWDPSignalId = S.Id
	WHERE H.Name = 'AnzahlLeiter'
) SourceMerkmalLeiter ON SourceMerkmalLeiter.VariablenId = V.Id
LEFT OUTER JOIN
(
	SELECT 
	CASE 
		WHEN H.Wert = 0 THEN 'D1'
		WHEN H.Wert = 1 THEN 'IMP'
		WHEN H.Wert = 2 THEN 'L1'
		WHEN H.Wert = 3 THEN 'L2'
		WHEN H.Wert = 4 THEN 'L3'
	END AS LampenKontrolle,
	S.VariablenId
	FROM HW_DPMerkmal H
	INNER JOIN HW_DPSignal S
	ON H.HWDPSignalId = S.Id
	WHERE H.Name = 'LampenKontrolle'
) SourceMerkmalLampenkontrolle ON SourceMerkmalLampenkontrolle.VariablenId = V.Id
LEFT OUTER JOIN
(
	SELECT 
	CASE 
		WHEN H.Wert = 0 THEN 'BLK1'
		WHEN H.Wert = 1 THEN 'BLK2'
		WHEN H.Wert = 2 THEN 'BLK3'
		WHEN H.Wert = 3 THEN 'BM2'
	END AS BlinkMode,
	S.VariablenId
	FROM HW_DPMerkmal H
	INNER JOIN HW_DPSignal S
	ON H.HWDPSignalId = S.Id
	WHERE H.Name = 'BlinkMode'
) SourceMerkmalBlinkMode ON SourceMerkmalBlinkMode.VariablenId = V.Id
LEFT OUTER JOIN
(
	SELECT 
	CASE 
		WHEN H.Wert = 0 THEN 'Binär'
		WHEN H.Wert = 1 THEN 'BCD'
		WHEN H.Wert = 2 THEN 'GRAY'
	END AS MesswertCode,
	S.VariablenId
	FROM HW_DPMerkmal H
	INNER JOIN HW_DPSignal S
	ON H.HWDPSignalId = S.Id
	WHERE H.Name = 'MesswertCode'
) SourceMerkmalMesswertCode ON SourceMerkmalMesswertCode.VariablenId = V.Id
ORDER BY DPModus



SELECT * FROM Signal WHERE TypId IN (SELECT Id FROM SignalTyp WHERE Id > 0)
ORDER BY TypId




ORDER BY ModulTYP

DROP VIEW M1InterfaceView
DROP VIEW ParameterView

SELECT DPModus
FROM HW_DPSignal
Order by DPModus

SELECT DPTyp
FROM HW_DPSignal
Order by DPTyp




SELECT *
FROM 
( 
	SELECT * 
	FROM SignalMitBezeichnung S
	INNER JOIN Variable V
	ON S.SIGNAL_ID = V.SignalId
) AS Source PIVOT(FOR [Id] IN( [Variable1], [Variable2], [Variable3])) AS PivotTable 


SELECT * 
	FROM SignalMitBezeichnung S
	INNER JOIN Variable V
	ON S.SIGNAL_ID = V.SignalId
	INNER JOIN VarQuSe Q
	ON Q.VariableId = V.Id


SELECT * 
FROM HW_DPSignal S
INNER JOIN HW_DPMerkmal M
ON S.Id = M.HWDPSignalId
WHERE S.VariablenId = 1875068

SELECT *
FROM HWModul H
INNER JOIN HWModulMerkmal M
ON H.Id = M.HWModulId
WHERE EXISTS (SELECT Id FROM HW_DPSignal WHERE VariablenId = 1875068 )

SELECT Id FROM HW_DPSignal S
WHERE S.VariablenId = 1875068


SELECT * FROM HW_DPMerkmal
ORDER BY Name

SELECT * FROM HWModulMerkmal
ORDER BY Name

SELECT * FROM Variable

SELECT ModulTypId FROM HWModul
Order BY ModulTypId

SELECT Id FROM SignalFullName
WHERE Name = '1.1BAA21.CE220B.XH32.PW00'

SELECT * FROM Signal
WHERE Id = 1861033

SELECT Name FROM AnlagenObjekt
WHERE Id=13484

SELECT KommentarText, Wert, 
CASE WHEN HatZeit = 1 THEN 'x' ELSE '' END AS Zeiteinbindung,
CASE WHEN HatBackup = 1 THEN 'x' ELSE '' END AS HatBackup,
CASE WHEN HatImpulsBefehl = 1 THEN 'x' ELSE '' END AS Impulsbefehl,
CASE WHEN HatPrivileg = 1 THEN 'x' ELSE '' END AS ÜbertragungMitPrio,
CASE WHEN HatRedundanz = 1 THEN '' ELSE 'x' END AS NichtRedundant, Id
FROM Signal

SELECT
	CASE 
		WHEN HatZeit = 1 THEN 'x'
	END AS Zeiteinbindung,
	CASE 
		WHEN HatBackup = 1 THEN 'x' 
	END AS HatBackup,
	CASE
		WHEN HatImpulsBefehl = 1 THEN 'x'
	END AS Impulsbefehl,
	CASE
		WHEN HatPrivileg = 1 THEN 'x'
	END AS ÜbertragungMitPrio,
	CASE
		WHEN HatRedundanz = 1 THEN ' ' ELSE 'x'
	END AS NichtRedundant
FROM Signal

SELECT S.KonfigurationId AS Konfiguration, Var.StaNr AS Station,
CASE 
	WHEN Var.HatQuSVI = 1 THEN 'Q'
	WHEN Var.HatSeSVI = 1 THEN 'S'
	ELSE '' 
END AS SVI_Q_S, 
V.Id AS VariablenId, V.SignalId AS SignalId
FROM VarQuSe Var
INNER JOIN Variable V
ON Var.VariableId = V.Id
LEFT OUTER JOIN Station S
ON Var.StaNr = S.Id
ORDER BY SVI_Q_S

SELECT * FROM VarQuSe
Order By HatSeSVI



SELECT S.KonfigurationId AS Konfiguration, Var.StaNr AS Station,
CASE 
	WHEN Var.HatQuMMI = 1 THEN 'Q'
	WHEN Var.HatSeMMI = 1 THEN 'S'
	ELSE '' 
END AS Ritop_Q_S, 
V.Id AS VariablenId, V.SignalId AS SignalId
FROM VarQuSe Var
INNER JOIN Variable V
ON Var.VariableId = V.Id
LEFT OUTER JOIN Station S
ON Var.StaNr = S.Id




SELECT K.Nummer AS Konfigurations_Nr, S.Nummer AS Stations_Nr, HWM.SteckplatzNummer AS Modul_Steckplatznummer, 
HWDPS.DPNummer AS DP_Nummer, HWDPS.AnzahlDP AS Anzahl_DP,
CASE WHEN HWDPS.DPTypId = 0 OR HWDPS.DPTypId = 2 THEN 'E' ELSE 'A' END AS DPTyp_EA,
CASE WHEN HWDPS.IstInvertiert = 1 THEN 'x' ELSE ' ' END AS Inv,
DPM.Name AS DPModus,
MT.Name AS ModulTYP, SourceM.Mittelwert, SourceG.DigitalesFilter,
SourceT.Transferzeit, SourceF.Fehlerintegrator,  V.Id AS VariablenId, V.SignalId AS SIGNAL_ID
FROM Variable V
INNER JOIN Station S
ON S.Id = V.StationId
INNER JOIN Konfiguration K
ON S.KonfigurationId = K.Id
INNER JOIN HW_DPSignal HWDPS
ON V.Id = HWDPS.VariablenId
INNER JOIN DPModus DPM
ON HWDPS.DPModusId = DPM.Id AND HWDPS.DPTypId = DPM.DPTypId
INNER JOIN DPTyp DT
ON DT.Id = HWDPS.DPTypId
INNER JOIN HWModul HWM
ON HWM.Id = HWDPS.HWModulId
INNER JOIN ModulTyp MT
ON MT.Id = HWM.ModulTypId
LEFT OUTER JOIN
(
	SELECT H.Wert AS Mittelwert, S.VariablenId
	FROM HW_DPMerkmal H
	INNER JOIN HW_DPSignal S
	ON H.HWDPSignalId = S.Id
	WHERE H.Name = 'Mittelwert'
) SourceM ON SourceM.VariablenId = V.Id
LEFT OUTER JOIN
(
	SELECT H.Wert AS DigitalesFilter, S.VariablenId
	FROM HW_DPMerkmal H
	INNER JOIN HW_DPSignal S
	ON H.HWDPSignalId = S.Id
	WHERE H.Name = 'GrenzFrequenz'
) SourceG ON SourceG.VariablenId = V.Id
LEFT OUTER JOIN
(
	SELECT H.Wert AS Transferzeit, S.VariablenId
	FROM HW_DPMerkmal H
	INNER JOIN HW_DPSignal S
	ON H.HWDPSignalId = S.Id
	WHERE H.Name = 'Transferzeit'
) SourceT ON SourceT.VariablenId = V.Id
LEFT OUTER JOIN
(
	SELECT H.Wert AS Fehlerintegrator, S.VariablenId
	FROM HW_DPMerkmal H
	INNER JOIN HW_DPSignal S
	ON H.HWDPSignalId = S.Id
	WHERE H.Name = 'FehlerIntegrator'
) SourceF ON SourceF.VariablenId = V.Id