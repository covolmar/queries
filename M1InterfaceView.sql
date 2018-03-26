SELECT K.Name AS riflex_io_configuration_name, S.Name AS riflex_io_station_name, K.Nummer AS riflex_io_configuration, S.Nummer AS riflex_io_station,
HWM.SteckplatzNummer AS riflex_io_module, MT.Name AS riflex_io_modul_name,
CASE WHEN HWDPS.DPTypId = 0 OR HWDPS.DPTypId = 2 THEN 'E' ELSE 'A' END AS riflex_io_direction,
HWDPS.DPNummer AS riflex_io_start_datapoint, (HWDPS.DPNummer + HWDPS.AnzahlDP) AS riflex_io_end_datapoint,
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
END AS riflex_io_signal_mode, 
CASE
	WHEN SourceSkaY0.SkalierungY0 IS NOT NULL AND SourceSkaY1.SkalierungY1 IS NOT NULL THEN SourceSkaY0.SkalierungY0 + '..' + SourceSkaY1.SkalierungY1
	ELSE ''
END AS riflex_io_measurement_range,
CASE WHEN HWDPS.IstInvertiert = 1 THEN 'x' ELSE ' ' END AS riflex_io_inversion,
SourceM.Mittelwert AS riflex_io_average, SourceG.DigitalesFilter AS riflex_io_cutoff_f,
SourceT.Transferzeit AS riflex_io_transfer_time, SourceF.Fehlerintegrator AS riflex_io_failure_integrator,  V.Id AS VariableId, V.SignalId AS SignalId, S.Id AS StationId
FROM Variable V
LEFT OUTER JOIN Station S
ON S.Id = V.StationId
LEFT OUTER JOIN Konfiguration K
ON S.KonfigurationId = K.Id
LEFT OUTER JOIN HW_DPSignal HWDPS
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
	SELECT H.Wert AS SkalierungY0, S.VariablenId
	FROM HW_DPMerkmal H
	INNER JOIN HW_DPSignal S
	ON H.HWDPSignalId = S.Id
	WHERE H.Name = 'WertY0'
) SourceSkaY0 ON SourceSkaY0.VariablenId = V.Id
LEFT OUTER JOIN
(
	SELECT H.Wert AS SkalierungY1, S.VariablenId
	FROM HW_DPMerkmal H
	INNER JOIN HW_DPSignal S
	ON H.HWDPSignalId = S.Id
	WHERE H.Name = 'WertY1'
) SourceSkaY1 ON SourceSkaY1.VariablenId = V.Id
LEFT OUTER JOIN
(
	SELECT 
	CASE 
		WHEN H.Wert = 0 THEN '2'
		WHEN H.Wert = 1 THEN '3'
		WHEN H.Wert = 2 THEN '4'
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