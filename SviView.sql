SELECT K.Nummer AS riflex_svi_configuration, S.Nummer AS riflex_svi_station,
CASE 
	WHEN Q.HatQuSVI = 1 THEN 'Q'
	WHEN Q.HatSeSVI = 1 THEN 'S'
	ELSE '' 
END AS riflex_svi_direction, 
V.Id AS VariableId, V.SignalId AS SignalId, S.Id AS StationId
FROM Variable V
INNER JOIN VarQuSe Q
ON Q.VariableId = V.Id
INNER JOIN Station S
ON V.StationId = S.Id
INNER JOIN Konfiguration K
ON K.Id = S.KonfigurationId