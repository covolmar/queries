--SELECT MAX(K.Nummer) AS riflex_variable_configuration,
--MAX(CASE
--	WHEN Q.VarQuell IS NULL OR LTRIM(RTRIM(Q.VarQuell)) = '' THEN NULL
--	ELSE Q.StaNr
--END) AS riflex_variable_source_station,
--MAX(CASE
--	WHEN Q.VarSenk IS NULL OR LTRIM(RTRIM(Q.VarSenk)) = '' THEN NULL
--	ELSE Q.StaNr
--END) AS riflex_variable_destination_station,
--V.Id AS VariablenId, MAX(V.SignalId) AS SignalId, MAX(S.Id) AS StationId
--FROM Variable V
--LEFT OUTER JOIN Station S
--ON V.StationId = S.Id
--LEFT OUTER JOIN Konfiguration K
--ON K.Id = S.KonfigurationId
--LEFT OUTER JOIN VarQuSe Q
--ON Q.VariableId = V.Id
--GROUP BY V.Id


SELECT K.Nummer AS riflex_variable_configuration,
CASE
	WHEN Q.VarQuell IS NULL OR LTRIM(RTRIM(Q.VarQuell)) = '' THEN NULL
	ELSE Q.StaNr
END AS riflex_variable_source_station,
CASE
	WHEN Q.VarSenk IS NULL OR LTRIM(RTRIM(Q.VarSenk)) = '' THEN NULL
	ELSE Q.StaNr
END AS riflex_variable_destination_station,
V.Id AS VariablenId,V.SignalId AS SignalId, S.Id AS StationId
FROM Variable V
LEFT OUTER JOIN Station S
ON V.StationId = S.Id
LEFT OUTER JOIN Konfiguration K
ON K.Id = S.KonfigurationId
LEFT OUTER JOIN VarQuSe Q
ON Q.VariableId = V.Id
ORDER BY VariableId


--SELECT Konf_Nr, Stat_Nr, V.Id, V.SignalId, Sub.StationId
--FROM Variable V
--LEFT OUTER JOIN
--(
--	SELECT K.Nummer AS Konf_Nr, S.Nummer AS Stat_Nr, S.Id AS StationId
--	FROM Konfiguration K
--	INNER JOIN Station S
--	ON S.KonfigurationId = K.Id
--) Sub ON Sub.StationId = V.StationId
