SELECT 
CASE
	WHEN Q.HatQuMMI = 1 OR Q.HatSeMMI = 1 THEN CAST( Sub.Konf_Nr AS VARCHAR(6) )
	ELSE CAST( '' AS VARCHAR(1) )
END AS riflex_ritop_configuration,
CASE
	WHEN Q.HatQuMMI = 1 OR Q.HatSeMMI = 1 THEN CAST( Sub.Stat_Nr AS VARCHAR(6) )
	ELSE CAST( '' AS VARCHAR(1) )
END AS riflex_ritop_station,
CASE 
	WHEN Q.HatQuMMI = 1 THEN 'Q'
	WHEN Q.HatSeMMI = 1 THEN 'S'
	ELSE CAST( '' AS varchar(1) )
END AS riflex_ritop_direction, 
V.Id AS VariableId, V.SignalId AS SignalId, Sub.StationId
FROM Variable V
INNER JOIN VarQuSe Q
ON Q.VariableId = V.Id
INNER JOIN
(
	SELECT K.Nummer AS Konf_Nr, S.Nummer AS Stat_Nr, S.Id AS StationId
	FROM Konfiguration K
	INNER JOIN Station S
	ON S.KonfigurationId = K.Id
)Sub ON Sub.Stat_Nr = Q.StaNr
WHERE Q.HatQuMMI = 1 OR Q.HatSeMMI = 1
