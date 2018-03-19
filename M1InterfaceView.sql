CREATE VIEW M1InterfaceView AS
SELECT K.Nummer AS Konfigurations_Nr, S.Nummer AS Stations_Nr, HWDPS.DPModus AS DPModus,
CASE WHEN HWDPS.DPTyp = 0 OR HWDPS.DPTyp = 2 THEN 'E' ELSE 'A' END AS DPTyp_EA, 
CASE WHEN HWDPS.IstInvertiert = 1 THEN 'x' ELSE ' ' END AS Inv,
HWM.SteckplatzNummer AS Modul_Steckplatznummer, HWM.ModulTyp AS ModulTYP,
HWDPS.DPNummer AS DP_Nummer, HWDPS.AnzahlDP AS Anzahl_DP, SourceM.Mittelwert, SourceG.DigitalesFilter,
SourceT.Transferzeit, SourceF.Fehlerintegrator,  V.Id AS VariablenId, V.SignalId AS SIGNAL_ID
FROM Variable V
INNER JOIN Station S
ON S.Id = V.StationId
INNER JOIN Konfiguration K
ON S.KonfigurationId = K.Id
INNER JOIN HW_DPSignal HWDPS
ON V.Id = HWDPS.VariablenId
INNER JOIN HWModul HWM
ON HWM.Id = HWDPS.HWModulId
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