SELECT
CASE
	WHEN Q.HatQuSVI = 1 OR Q.HatSeSVI = 1 THEN CAST( Sub.Konf_Nr AS VARCHAR(6) )
	ELSE CAST( '' AS VARCHAR(1) )
END AS riflex_svi_configuration,
CASE
	WHEN Q.HatQuSVI = 1 OR Q.HatSeSVI = 1 THEN CAST( Sub.Stat_Nr AS VARCHAR(6) )
	ELSE CAST( '' AS varchar(1) )
END AS riflex_svi_station,
CASE 
	WHEN Q.HatQuSVI = 1 THEN 'Q'
	WHEN Q.HatSeSVI = 1 THEN 'S'
	ELSE CAST( '' AS varchar(1) )
END AS riflex_svi_direction, 
V.Id AS VariableId, V.SignalId AS SignalId, Sub.StationId
FROM Variable V
LEFT OUTER JOIN VarQuSe Q
ON Q.VariableId = V.Id
LEFT OUTER JOIN
(
	SELECT K.Nummer AS Konf_Nr, S.Nummer AS Stat_Nr, S.Id AS StationId
	FROM Konfiguration K
	INNER JOIN Station S
	ON S.KonfigurationId = K.Id
)Sub ON Sub.Stat_Nr = Q.StaNr
WHERE Q.HatQuSVI = 1 OR Q.HatSeSVI = 1