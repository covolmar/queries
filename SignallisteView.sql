SELECT S.Id AS SignalId, MAX(AO0) AS AO0, MAX(AO1) AS A01, MAX(AO2) AS AO2, MAX(AO3) AS AO3, MAX(S.Name) AS SO,
MAX(BEREICH) AS BEREICH, MAX(BAUWERK) AS BAUWERK, MAX(FUNKTION) AS FUNKTION, MAX(ELEMENT) AS ELEMENT, MAX(S.IndexText) AS INDEX_TEXT, MAX(ST.Name) AS Typ,

MAX(MFE0.MFEText_0) AS MFEText0, MAX(MFE1.MFEText_1) AS MFEText1, MAX(MFE2.MFEText_2) AS MFEText2, MAX(MFE3.MFEText_3) AS MFEText3, 
MAX(MFE4.MFEText_4) AS MFEText4, MAX(MFE5.MFEText_5) AS MFEText5, MAX(MFE6.MFEText_6) AS MFEText6, MAX(MFE7.MFEText_7) AS MFEText7,
 
MAX(CASE
	WHEN HWM.SteckplatzNummer IS NOT NULL THEN K.Nummer ELSE NULL
END) AS Konfigurations_Nr, 

MAX(CASE 
WHEN HWM.SteckplatzNummer IS NOT NULL THEN Stat.Nummer ELSE NULL
END) AS Stations_Nr, 

MAX(HWM.SteckplatzNummer) AS Modul_Steckplatznummer, 
MAX(HWDPS.DPNummer) AS DP_Nummer, MAX(HWDPS.AnzahlDP) AS Anzahl_DP,
MAX(CASE WHEN HWDPS.DPTypId = 0 OR HWDPS.DPTypId = 2 THEN 'E' ELSE 'A' END) AS DPTyp_EA,
MAX(CASE WHEN HWDPS.IstInvertiert = 1 THEN 'x' ELSE ' ' END) AS Inv,
MAX(CASE 
	WHEN DPM.Name = 'PT100' THEN 'PT100_' + CAST(SourceMerkmalLeiter.AnzahlLeiter AS VARCHAR(10))
	WHEN DPM.Name = 'PT1000' THEN 'PT1000_' + CAST(SourceMerkmalLeiter.AnzahlLeiter AS VARCHAR(10))
	WHEN DPM.Name = 'Lampenkontrolle Ausgang' THEN SourceMerkmalLampenkontrolle.LampenKontrolle
	WHEN DPM.Name = 'Alarm-Ausgang (S/SA)' THEN SourceMerkmalBlinkMode.BlinkMode
	WHEN (DPM.Name = 'Messwert Eingang' OR DPM.Name = 'Messwert Ausgang') AND (HWDPS.DPTypId = 0 OR HWDPS.DPTypId = 1) THEN SourceMerkmalMesswertCode.MesswertCode
	WHEN DPM.Name = 'Digital Ein-/Ausgang' AND HWDPS.DPTypId = 1 AND LEN(SourceMerkmalLampenkontrolle.LampenKontrolle) > 0 THEN SourceMerkmalLampenkontrolle.LampenKontrolle
	WHEN DPM.Name = 'Digital Ein-/Ausgang' AND HWDPS.DPTypId = 1 AND SourceMerkmalLampenkontrolle.LampenKontrolle IS NULL THEN 'D1'
	WHEN DPM.Name = 'Digital Ein-/Ausgang' AND HWDPS.DPTypId = 0 THEN ' '
	ELSE DPM.Name
END) AS DPModus,
MAX(MT.Name) AS ModulTYP, MAX(SourceM.Mittelwert) AS Mittelwert, MAX(SourceG.DigitalesFilter) AS DigitalesFilter, MAX(SourceT.Transferzeit) AS Transferzeit, MAX(SourceF.Fehlerintegrator) AS Fehlerintegrator,
MAX(S.KommentarText) AS Kommentar, MAX(S.Wert) AS Startwert, Zeiteinbindung =
MAX(CASE 
	WHEN HatZeit = 1 THEN 'x' ELSE ' '
END),
Impulsbefehl =
MAX(CASE
	WHEN HatImpulsBefehl = 1 THEN 'x' ELSE ' '
END),
UebertragungMitPrio =
MAX(CASE
	WHEN HatPrivileg = 1 THEN 'x' ELSE ' '
END),
NichtRedundant =
MAX(CASE
	WHEN HatRedundanz = 1 THEN ' ' ELSE 'x'
END),
MAX(S.DavosVerdichtung) AS Verdichtung, MAX(S.DavosIntervall) AS Intervall, MAX(S.DavosElemente) AS Elemente,
MAX(Q.ParaNr) AS ParaBlockNr, MAX(Q.ParaMin) AS ParaMin, MAX(Q.ParaMax) AS ParaMax, MAX(Q.ParaNKS) AS Nachkommastellen,

MAX(CASE 
	WHEN Q.HatQuSVI = 1 THEN Q.StaNr
	WHEN Q.HatSeSVI = 1 THEN Q.StaNr
	ELSE ' ' 
END) AS SVI_Station,
MAX(CASE 
	WHEN Q.HatQuSVI = 1 THEN 'Q'
	WHEN Q.HatSeSVI = 1 THEN 'S'
	ELSE ' ' 
END) AS SVI_Q_S,

MAX(CASE 
	WHEN Q.HatQuMMI = 1 THEN Q.StaNr
	WHEN Q.HatSeMMI = 1 THEN Q.StaNr
	ELSE ' '
END) AS Ritop_Station,
MAX(CASE 
	WHEN Q.HatQuMMI = 1 THEN 'Q'
	WHEN Q.HatSeMMI = 1 THEN 'S'
	ELSE ' '
END) AS Ritop_Q_S
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
LEFT OUTER JOIN Variable V
ON V.SignalId = S.Id
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
LEFT OUTER JOIN Station Stat
ON Stat.Id = V.StationId
LEFT OUTER JOIN Konfiguration K
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
		WHEN H.Wert = 0 THEN 'Bin�r'
		WHEN H.Wert = 1 THEN 'BCD'
		WHEN H.Wert = 2 THEN 'GRAY'
	END AS MesswertCode,
	DPSig.VariablenId
	FROM HW_DPMerkmal H
	INNER JOIN HW_DPSignal DPSig
	ON H.HWDPSignalId = DPSig.Id
	WHERE H.Name = 'MesswertCode'
) SourceMerkmalMesswertCode ON SourceMerkmalMesswertCode.VariablenId = V.Id
LEFT OUTER JOIN VarQuSe Q
ON Q.VariableId = V.Id
GROUP BY S.Id
