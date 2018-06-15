SELECT 
CASE
	WHEN Q.ParaNr IS NOT NULL THEN K.Nummer
END AS riflex_parameter_configuration,
CASE
	WHEN Q.ParaNr IS NOT NULL THEN S.Nummer
END AS riflex_parameter_station,
Q.ParaNr AS riflex_parameter_block_number, Q.ParaMin AS riflex_parameter_min,
Q.ParaMax AS riflex_parameter_max, Q.ParaNKS AS riflex_parameter_decimal_place,
Q.VariableId, V.SignalId, S.Id AS StationId
FROM Variable V
INNER JOIN VarQuSe Q
ON Q.VariableId = V.Id
INNER JOIN Station S
ON S.Id = V.StationId
INNER JOIN Konfiguration K
ON K.Id = S.KonfigurationId
WHERE Q.ParaNr IS NOT NULL