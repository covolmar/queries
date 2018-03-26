SELECT K.Nummer AS riflex_parameter_configuration, Q.StaNr AS riflex_parameter_station,
Q.ParaNr AS riflex_parameter_block_number, Q.ParaMin AS riflex_parameter_min,
Q.ParaMax AS riflex_parameter_max, Q.ParaNKS AS riflex_parameter_decimal_place,
Q.VariableId, V.SignalId, S.Id AS StationId
FROM Variable V
LEFT OUTER JOIN VarQuSe Q
ON Q.VariableId = V.Id
LEFT OUTER JOIN Station S
ON S.Id = Q.StaNr
INNER JOIN Konfiguration K
ON K.Id = S.KonfigurationId