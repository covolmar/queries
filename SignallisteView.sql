SELECT S.Id AS SIGNAL_ID, V.Id AS VariablenId, AO0, AO1, AO2, AO3, S.Name AS SO, BEREICH, BAUWERK, FUNKTION, ELEMENT, S.IndexText AS INDEX_TEXT, ST.Name AS Typ, V.StationId AS Q_S_Station,
MFE0.MFEText_0, MFE1.MFEText_1, MFE2.MFEText_2, MFE3.MFEText_3, MFE4.MFEText_4, MFE5.MFEText_5, MFE6.MFEText_6, MFE7.MFEText_7,
K.Nummer AS Konfigurations_Nr, Stat.Nummer AS Stations_Nr, HWM.SteckplatzNummer AS Modul_Steckplatznummer, 
HWDPS.DPNummer AS DP_Nummer, HWDPS.AnzahlDP AS Anzahl_DP,
CASE WHEN HWDPS.DPTypId = 0 OR HWDPS.DPTypId = 2 THEN 'E' ELSE 'A' END AS DPTyp_EA,
CASE WHEN HWDPS.IstInvertiert = 1 THEN 'x' ELSE ' ' END AS Inv,
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
MT.Name AS ModulTYP, SourceM.Mittelwert, SourceG.DigitalesFilter, SourceT.Transferzeit, SourceF.Fehlerintegrator,
S.KommentarText, S.Wert, Zeiteinbindung =
CASE 
	WHEN HatZeit = 1 THEN 'x' ELSE ' '
END,
Impulsbefehl =
CASE
	WHEN HatImpulsBefehl = 1 THEN 'x' ELSE ' '
END,
UebertragungMitPrio =
CASE
	WHEN HatPrivileg = 1 THEN 'x' ELSE ' '
END,
NichtRedundant =
CASE
	WHEN HatRedundanz = 1 THEN ' ' ELSE 'x'
END,
S.DavosVerdichtung AS Verdichtung, S.DavosIntervall AS Intervall, S.DavosElemente AS Elemente,
Q.ParaNr AS ParaBlockNr, Q.ParaMin AS ParaMin, Q.ParaMax AS ParaMax, Q.ParaNKS AS Nachkommastellen,
CASE 
	WHEN Q.HatQuSVI = 1 THEN 'Q'
	WHEN Q.HatSeSVI = 1 THEN 'S'
	ELSE ' ' 
END AS SVI_Q_S,
CASE 
	WHEN Q.HatQuMMI = 1 THEN 'Q'
	WHEN Q.HatSeMMI = 1 THEN 'S'
	ELSE ' '
END AS Ritop_Q_S
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
LEFT OUTER JOIN 
(
	SELECT MFEText AS MFEText_0, SignalId AS Signal_Id 
	FROM MFEText
	WHERE Nummer = 0
) MFE0 ON S.Id = MFE0.Signal_Id
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
INNER JOIN Variable V
ON V.SignalId = S.Id
INNER JOIN Station Stat
ON Stat.Id = V.StationId
INNER JOIN Konfiguration K
ON Stat.KonfigurationId = K.Id
LEFT OUTER JOIN HW_DPSignal HWDPS
ON V.Id = HWDPS.VariablenId
LEFT OUTER JOIN DPModus DPM
ON HWDPS.DPModusId = DPM.Id AND HWDPS.DPTypId = DPM.DPTypId
LEFT OUTER JOIN DPTyp DT
ON DT.Id = HWDPS.DPTypId
LEFT OUTER JOIN HWModul HWM
ON HWM.Id = HWDPS.HWModulId
LEFT OUTER JOIN ModulTyp MT
ON MT.Id = HWM.ModulTypId
LEFT OUTER JOIN
(
	SELECT H.Wert AS Mittelwert, DPSig.VariablenId
	FROM HW_DPMerkmal H
	INNER JOIN HW_DPSignal DPSig
	ON H.HWDPSignalId = DPSig.Id
	WHERE H.Name = 'Mittelwert'
) SourceM ON SourceM.VariablenId = V.Id
LEFT OUTER JOIN
(
	SELECT H.Wert AS DigitalesFilter, DPSig.VariablenId
	FROM HW_DPMerkmal H
	INNER JOIN HW_DPSignal DPSig
	ON H.HWDPSignalId = DPSig.Id
	WHERE H.Name = 'GrenzFrequenz'
) SourceG ON SourceG.VariablenId = V.Id
LEFT OUTER JOIN
(
	SELECT H.Wert AS Transferzeit, DPSig.VariablenId
	FROM HW_DPMerkmal H
	INNER JOIN HW_DPSignal DPSig
	ON H.HWDPSignalId = DPSig.Id
	WHERE H.Name = 'Transferzeit'
) SourceT ON SourceT.VariablenId = V.Id
LEFT OUTER JOIN
(
	SELECT H.Wert AS Fehlerintegrator, DPSig.VariablenId
	FROM HW_DPMerkmal H
	INNER JOIN HW_DPSignal DPSig
	ON H.HWDPSignalId = DPSig.Id
	WHERE H.Name = 'FehlerIntegrator'
) SourceF ON SourceF.VariablenId = V.Id
LEFT OUTER JOIN
(
	SELECT 
	CASE 
		WHEN H.Wert = 0 THEN '2'
		WHEN H.Wert = 1 THEN '3'
		WHEN H.Wert = 2 THEN '4'
	END AS AnzahlLeiter, 
	DPSig.VariablenId
	FROM HW_DPMerkmal H
	INNER JOIN HW_DPSignal DPSig
	ON H.HWDPSignalId = DPSig.Id
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
	DPSig.VariablenId
	FROM HW_DPMerkmal H
	INNER JOIN HW_DPSignal DPSig
	ON H.HWDPSignalId = DPSig.Id
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
	DPSig.VariablenId
	FROM HW_DPMerkmal H
	INNER JOIN HW_DPSignal DPSig
	ON H.HWDPSignalId = DPSig.Id
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
	DPSig.VariablenId
	FROM HW_DPMerkmal H
	INNER JOIN HW_DPSignal DPSig
	ON H.HWDPSignalId = DPSig.Id
	WHERE H.Name = 'MesswertCode'
) SourceMerkmalMesswertCode ON SourceMerkmalMesswertCode.VariablenId = V.Id
INNER JOIN VarQuSe Q
ON Q.VariableId = V.Id
