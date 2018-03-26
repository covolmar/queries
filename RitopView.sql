SELECT K.Nummer AS riflex_ritop_configuration, S.Nummer AS riflex_ritop_station,
CASE 
	WHEN Q.HatQuMMI = 1 THEN 'Q'
	WHEN Q.HatSeMMI = 1 THEN 'S'
	ELSE '' 
END AS riflex_ritop_direction, 
V.Id AS VariableId, V.SignalId AS SignalId, S.Id AS StationId
FROM Variable V
INNER JOIN VarQuSe Q
ON Q.VariableId = V.Id
INNER JOIN Station S
ON V.StationId = S.Id
INNER JOIN Konfiguration K
ON K.Id = S.KonfigurationId